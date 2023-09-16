//
//  BookIndex.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import Foundation

struct BookIndexItem: Identifiable {
    let id = UUID()
    let header: String
    let lines: [BookIndexLineItem]
}

struct BookIndexLineItem: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let index: String
}

// BookIndexView(作品別検索)に渡し、各BookListViewを出力させるための情報
struct BookIndex {
    static let bookIndex: [BookIndexItem] = [
        BookIndexItem(header: "あ行",
                      lines: [BookIndexLineItem(name: "あ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_a1.html", index: "a"),
                              BookIndexLineItem(name: "い", url: "https://www.aozora.gr.jp/index_pages/sakuhin_i1.html", index: "i"),
                              BookIndexLineItem(name: "う", url: "https://www.aozora.gr.jp/index_pages/sakuhin_u1.html", index: "u"),
                              BookIndexLineItem(name: "え", url: "https://www.aozora.gr.jp/index_pages/sakuhin_e1.html", index: "e"),
                              BookIndexLineItem(name: "お", url: "https://www.aozora.gr.jp/index_pages/sakuhin_o1.html", index: "o")]),
        BookIndexItem(header: "か行",
                      lines: [BookIndexLineItem(name: "か", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ka1.html", index: "ka"),
                              BookIndexLineItem(name: "き", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ki1.html", index: "ki"),
                              BookIndexLineItem(name: "く", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ku1.html", index: "ku"),
                              BookIndexLineItem(name: "け", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ke1.html", index: "ke"),
                              BookIndexLineItem(name: "こ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ko1.html", index: "ko")]),
        BookIndexItem(header: "さ行",
                      lines: [BookIndexLineItem(name: "さ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_sa1.html", index: "sa"),
                              BookIndexLineItem(name: "し", url: "https://www.aozora.gr.jp/index_pages/sakuhin_si1.html", index: "si"),
                              BookIndexLineItem(name: "す", url: "https://www.aozora.gr.jp/index_pages/sakuhin_su1.html", index: "su"),
                              BookIndexLineItem(name: "せ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_se1.html", index: "se"),
                              BookIndexLineItem(name: "そ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_so1.html", index: "so")]),
        BookIndexItem(header: "た行",
                      lines: [BookIndexLineItem(name: "た", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ta1.html", index: "ta"),
                              BookIndexLineItem(name: "ち", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ti1.html", index: "ti"),
                              BookIndexLineItem(name: "つ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_tu1.html", index: "tu"),
                              BookIndexLineItem(name: "て", url: "https://www.aozora.gr.jp/index_pages/sakuhin_te1.html", index: "te"),
                              BookIndexLineItem(name: "と", url: "https://www.aozora.gr.jp/index_pages/sakuhin_to1.html", index: "to")]),
        BookIndexItem(header: "な行",
                      lines: [BookIndexLineItem(name: "な", url: "https://www.aozora.gr.jp/index_pages/sakuhin_na1.html", index: "na"),
                              BookIndexLineItem(name: "に", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ni1.html", index: "ni"),
                              BookIndexLineItem(name: "ぬ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_nu1.html", index: "nu"),
                              BookIndexLineItem(name: "ね", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ne1.html", index: "ne"),
                              BookIndexLineItem(name: "の", url: "https://www.aozora.gr.jp/index_pages/sakuhin_no1.html", index: "no")]),
        BookIndexItem(header: "は行",
                      lines: [BookIndexLineItem(name: "は", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ha1.html", index: "ha"),
                              BookIndexLineItem(name: "ひ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_hi1.html", index: "hi"),
                              BookIndexLineItem(name: "ふ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_hu1.html", index: "hu"),
                              BookIndexLineItem(name: "へ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_he1.html", index: "he"),
                              BookIndexLineItem(name: "ほ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ho1.html", index: "ho")]),
        BookIndexItem(header: "ま行",
                      lines: [BookIndexLineItem(name: "ま", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ma1.html", index: "ma"),
                              BookIndexLineItem(name: "み", url: "https://www.aozora.gr.jp/index_pages/sakuhin_mi1.html", index: "mi"),
                              BookIndexLineItem(name: "む", url: "https://www.aozora.gr.jp/index_pages/sakuhin_mu1.html", index: "mu"),
                              BookIndexLineItem(name: "め", url: "https://www.aozora.gr.jp/index_pages/sakuhin_me1.html", index: "me"),
                              BookIndexLineItem(name: "も", url: "https://www.aozora.gr.jp/index_pages/sakuhin_mo1.html", index: "mo")]),
        BookIndexItem(header: "や行",
                      lines: [BookIndexLineItem(name: "や", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ya1.html", index: "ya"),
                              BookIndexLineItem(name: "ゆ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_yu1.html", index: "yu"),
                              BookIndexLineItem(name: "よ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_yo1.html", index: "yo")]),
        BookIndexItem(header: "ら行",
                      lines: [BookIndexLineItem(name: "ら", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ra1.html", index: "ra"),
                              BookIndexLineItem(name: "り", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ri1.html", index: "ri"),
                              BookIndexLineItem(name: "る", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ru1.html", index: "ru"),
                              BookIndexLineItem(name: "れ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_re1.html", index: "re"),
                              BookIndexLineItem(name: "ろ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ro1.html", index: "ro")]),
        BookIndexItem(header: "わ行",
                      lines: [BookIndexLineItem(name: "わ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_wa1.html", index: "wa"),
                              BookIndexLineItem(name: "を", url: "https://www.aozora.gr.jp/index_pages/sakuhin_wo1.html", index: "wo"),
                              BookIndexLineItem(name: "ん", url: "https://www.aozora.gr.jp/index_pages/sakuhin_nn1.html", index: "nn")])
    ]
}
