//
//  AuthorCardViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation

class AuthorCardViewModel: ObservableObject {
    private var webScraping = WebScraping()
    private var textParser = TextParser()
    private var bookRealmModel = BookRealmModel()
    private var webReader = WebReader()
    
    @Published var cardNoArray: [String] = []
    @Published var bookArray: [String] = []
    @Published var authorName: String = ""
    @Published var bookInfoArray: [String] = []

    func getAuthorNameArray(_ authorNo: String) {
        Task {
            let url = "https://www.aozora.gr.jp/index_pages/person\(authorNo).html#sakuhin_list_1"
            let html = try await webScraping.fetchHTML(url)
            let (cardNoArray, bookArray, authorName, bookInfoArray) = textParser.forAuthorCard(html)
            await MainActor.run {
                self.cardNoArray = cardNoArray
                self.bookArray = bookArray
                self.authorName = authorName
                self.bookInfoArray = bookInfoArray
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
        itemToBeAdded.author = authorName
        itemToBeAdded.cardNo = cardNoArray[i]
        
        bookRealmModel.addData(itemToBeAdded)
    }
    
    func openBook(_ i: Int) {
        let cardNo = cardNoArray[i]
        webReader.openBook(cardNo)
    }
    
}
