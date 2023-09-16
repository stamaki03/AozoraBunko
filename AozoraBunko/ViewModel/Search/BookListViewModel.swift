//
//  BookListViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import Foundation

final class BookListViewModel: ObservableObject {
    private var webScraping = WebScraping()
    private var textParser = TextParser()
    private var bookRealmModel = BookRealmModel()
    private var webReader = WebReader()
    
    @Published var num: Int = 1
    @Published var bookArray: [String] = []
    @Published var bookInfoArray: [String] = []
    @Published var authorArray: [String] = []
    @Published var cardNoArray: [String] = []
    
    func getPageNumber(url: String) {
        Task {
            let html = try await webScraping.fetchHTML(url)
            let num = textParser.forBookList(html)
            
            await MainActor.run {
                self.num = num
            }
        }
    }
    
    func getBookNameArray(index: String, number: String) {
        Task {
            let url = "https://www.aozora.gr.jp/index_pages/sakuhin_\(index)\(number).html"
            let html = try await webScraping.fetchHTML(url)
            let (bookArray, bookInfoArray, authorArray, cardNoArray) = textParser.forBookList2(html)
            guard let bookArray = bookArray, let bookInfoArray = bookInfoArray, let authorArray = authorArray, let cardNoArray = cardNoArray else { return }
            
            await MainActor.run {
                self.bookArray = bookArray
                self.bookInfoArray = bookInfoArray
                self.authorArray = authorArray
                self.cardNoArray = cardNoArray
            }
        }
    }
    
    func saveData(_ i: Int) {
        // 読書中または読了した本に既にデータが存在する場合は処理を行わない
        if (bookRealmModel.readingBookItems.first(where: {$0.cardNo == cardNoArray[i]}) != nil) {return}
        if (bookRealmModel.finishedReadingBookItems.first(where: {$0.cardNo == cardNoArray[i]}) != nil) {return}
        
        let itemToBeAdded = ReadingBookItem()
        itemToBeAdded.id = UUID()
        itemToBeAdded.book = bookArray[i]
        itemToBeAdded.author = authorArray[i]
        itemToBeAdded.cardNo = cardNoArray[i]
        
        bookRealmModel.addData(itemToBeAdded)
    }
    
    func openBook(_ i: Int) {
        let cardNo = cardNoArray[i]
        webReader.openBook(cardNo)
    }
}
