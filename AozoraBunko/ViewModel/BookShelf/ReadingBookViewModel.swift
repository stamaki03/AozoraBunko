//
//  ReadingBookViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import Foundation
import RealmSwift

final class ReadingBookViewModel: ObservableObject {
    private var bookRealmModel = BookRealmModel()

    @Published var books: Results<ReadingBookItem>
    private var notificationTokens: [NotificationToken] = []

    init() {
        self.books = bookRealmModel.readingBookItems
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
        let items = bookRealmModel.readingBookItems
        guard let itemToBeRemoved = items.first(where: {$0.id == id}) else { return }
        bookRealmModel.deleteData(itemToBeRemoved)
    }
    
    func moveData(offsets: IndexSet, index: Int) {
        let itemToBeMoved = bookRealmModel.readingBookItems[offsets.first!]
        let tmpItem = ReadingBookItem()
        bookRealmModel.moveData(offsets, index, itemToBeMoved, tmpItem, bookRealmModel.readingBookItems)
    }
    
    func moveDataToFinishedReadingBook(_ value: ReadingBookItem) {
        let itemToBeAdded = FinishedReadingBookItem()
        itemToBeAdded.id = value.id
        itemToBeAdded.book = value.book
        itemToBeAdded.author = value.author
        itemToBeAdded.cardNo = value.cardNo
        bookRealmModel.addData(itemToBeAdded)
        self.deleteData(value.id)
    }
}
