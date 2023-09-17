//
//  RandomBookSearchViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/17.
//

import Foundation

final class RandomBookSearchViewModel: ObservableObject {
    private var webScraping = WebScraping()
    private var textParser = TextParser()
    private var bookRealmModel = BookRealmModel()
    private var webReader = WebReader()
    
    private var bookArray: [String] = []
    private var authorArray: [String] = []
    private var cardNoArray: [String] = []

    @Published var bookName: String = ""
    @Published var authorName: String = ""
    private var cardNo: String = ""

    func findBookRandomly() {
        Task {
            //let url = "https://www.aozora.gr.jp/access_ranking/\(calcTwoMonthsAgo())_xhtml.html"
            let url = "https://www.aozora.gr.jp/access_ranking/2022_xhtml.html"
            let html = try await webScraping.fetchHTML(url)
            let (bookArray, authorArray, cardNoArray) = textParser.forRanking(html)
            
            
            await MainActor.run {
                self.bookArray = bookArray
                self.authorArray = authorArray
                self.cardNoArray = cardNoArray
                
                let num = Int.random(in: 0..<bookArray.count)
                self.bookName = bookArray[num]
                self.authorName = authorArray[num]
                self.cardNo = cardNoArray[num]
            }
        }
    }
    
    // 2023年以降アクセスランキングページの更新が無いので、いったんこの関数は使わない
    // 月初に前月のランキングデータが存在していない期間が生じるため、確実にデータ取得できるように2ヶ月前のデータを取得対象とする
//    private func calcTwoMonthsAgo() -> String {
//        let twoMonthsAgo = Date(timeInterval: -60*60*24*60, since: Date())
//        let year = Calendar.current.component(.year, from: twoMonthsAgo)
//        let month = Calendar.current.component(.month, from: twoMonthsAgo)
//        let modifiedMonth = String(format: "%02d", month)
//        return "\(year)_\(modifiedMonth)"
//    }
    
    func saveData() {
        // 読書中または読了した本に既にデータが存在する場合は処理を行わない
        if (bookRealmModel.readingBookItems.first(where: {$0.cardNo == cardNo}) != nil) {return}
        if (bookRealmModel.finishedReadingBookItems.first(where: {$0.cardNo == cardNo}) != nil) {return}
        
        let itemToBeAdded = ReadingBookItem()
        itemToBeAdded.id = UUID()
        itemToBeAdded.book = bookName
        itemToBeAdded.author = authorName
        itemToBeAdded.cardNo = cardNo
        
        bookRealmModel.addData(itemToBeAdded)
    }

    func openWebBookPage() {
        webReader.openBook(cardNo)
    }
}
