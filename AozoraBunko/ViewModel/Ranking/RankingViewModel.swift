//
//  RankingViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/17.
//

import Foundation

final class RankingViewModel: ObservableObject {
    private var webScraping = WebScraping()
    private var textParser = TextParser()
    private var bookRealmModel = BookRealmModel()
    private var webReader = WebReader()
    
    @Published var bookArray: [String] = []
    @Published var authorArray: [String] = []
    @Published var cardNoArray: [String] = []
    
    func findRankingContents() {
        Task {
            //let url = "https://www.aozora.gr.jp/access_ranking/\(calcTwoMonthsAgo())_xhtml.html"
            let url = "https://www.aozora.gr.jp/access_ranking/2022_xhtml.html"
            let html = try await webScraping.fetchHTML(url)
            let (bookArray, authorArray, cardNoArray) = textParser.forRanking(html)
            
            await MainActor.run {
                // 表示件数は50件とする
                self.bookArray = Array(bookArray[0..<50])
                self.authorArray = Array(authorArray[0..<50])
                self.cardNoArray = Array(cardNoArray[0..<50])
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
