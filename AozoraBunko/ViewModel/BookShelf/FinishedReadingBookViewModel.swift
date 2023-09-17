//
//  FinishedReadingBookViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import Foundation
import RealmSwift

final class FinishedReadingBookViewModel: ObservableObject {
    private var bookRealmModel = BookRealmModel()
    
    @Published var books: Results<FinishedReadingBookItem>
    private var notificationTokens: [NotificationToken] = []

    init() {
        self.books = bookRealmModel.finishedReadingBookItems
        notificationTokens.append(books.observe { change in
            switch change {
            case let .initial(results):
                self.books = results
            case let .update(results, _, _, _):
                self.books = results
            case let .error(error):
                print(error.localizedDescription)
            }
        })
    }

    deinit {
        notificationTokens.forEach { $0.invalidate() }
    }
    
    func deleteData(_ id: UUID) {
        let items = bookRealmModel.finishedReadingBookItems
        guard let itemToBeRemoved = items.first(where: {$0.id == id}) else { return }
        bookRealmModel.deleteData(itemToBeRemoved)
    }
    
    func moveData(offsets: IndexSet, index: Int) {
        let itemToBeMoved = bookRealmModel.finishedReadingBookItems[offsets.first!]
        let tmpItem = FinishedReadingBookItem()
        bookRealmModel.moveData(offsets, index, itemToBeMoved, tmpItem, bookRealmModel.finishedReadingBookItems)
    }
    
    func moveDataToReadingBook(_ value: FinishedReadingBookItem) {
        let itemToBeAdded = ReadingBookItem()
        itemToBeAdded.id = value.id
        itemToBeAdded.book = value.book
        itemToBeAdded.author = value.author
        itemToBeAdded.cardNo = value.cardNo
        bookRealmModel.addData(itemToBeAdded)
        self.deleteData(value.id)
    }
}
