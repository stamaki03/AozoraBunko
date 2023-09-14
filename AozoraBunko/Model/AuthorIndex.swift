//
//  AuthorIndex.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import Foundation

struct AuthorIndexItem: Identifiable {
    let id = UUID()
    let name: String
    let url: String
}

// AuthorIndexView(作家別検索)に渡し、各AuthorListViewを出力させるための情報
struct AuthorIndex {
    static let authorIndex = [
        AuthorIndexItem(name: "あ行", url: "https://www.aozora.gr.jp/index_pages/person_a.html"),
        AuthorIndexItem(name: "か行", url: "https://www.aozora.gr.jp/index_pages/person_ka.html"),
        AuthorIndexItem(name: "さ行", url: "https://www.aozora.gr.jp/index_pages/person_sa.html"),
        AuthorIndexItem(name: "た行", url: "https://www.aozora.gr.jp/index_pages/person_ta.html"),
        AuthorIndexItem(name: "な行", url: "https://www.aozora.gr.jp/index_pages/person_na.html"),
        AuthorIndexItem(name: "は行", url: "https://www.aozora.gr.jp/index_pages/person_ha.html"),
        AuthorIndexItem(name: "ま行", url: "https://www.aozora.gr.jp/index_pages/person_ma.html"),
        AuthorIndexItem(name: "や行", url: "https://www.aozora.gr.jp/index_pages/person_ya.html"),
        AuthorIndexItem(name: "ら行", url: "https://www.aozora.gr.jp/index_pages/person_ra.html"),
        AuthorIndexItem(name: "わ行", url: "https://www.aozora.gr.jp/index_pages/person_wa.html")
    ]
}
