//
//  WebScraping.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation

// URLSessionでhtmlを取得
struct WebScraping {
    func fetchHTML(_ url: String) async throws -> String {
        let url = URL(string: url)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let html = String(data: data, encoding: .utf8)!
            return html
        } catch {
            return "error"
        }
    }
}
