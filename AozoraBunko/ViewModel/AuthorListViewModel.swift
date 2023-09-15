//
//  AuthorListViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation

class AuthorListViewModel: ObservableObject {
    private var webScraping = WebScraping()
    private var textParser = TextParser()
    
    @Published var authorArray: [String] = []
    @Published var authorNoArray: [String] = []
    
    // 検索用
    @Published var searchText = ""
    
    var searchResults: [Int] {
        var countArray: [Int] = []
        if searchText.isEmpty {
            for (i, _) in authorArray.enumerated() {
                countArray.append(i)
            }
            return countArray
        } else {
            for (i, element) in authorArray.enumerated() {
                if element.contains(searchText) {
                    countArray.append(i)
                }
            }
            return countArray
        }
    }
    
    func getAuthorNameArray(_ url: String) {
        Task {
            let html = try await webScraping.fetchHTML(url)
            let (authorArray, authorNoArray) = textParser.forAuthorList(html)
            await MainActor.run {
                self.authorArray = authorArray
                self.authorNoArray = authorNoArray
            }
        }
    }
}
