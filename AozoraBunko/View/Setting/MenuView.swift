//
//  MenuView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    if let url = URL(string: "https://www.aozora.gr.jp/") {
                        Link("青空文庫ホームページ", destination: url)
                    }
                }
                Section() {
                    if let url = URL(string: "https://www.aozora.gr.jp/guide/aozora_bunko_hayawakari.html") {
                        Link("青空文庫早わかり", destination: url)
                    }
                    if let url = URL(string: "https://www.aozora.gr.jp/guide/aozora_bunko_faq.html") {
                        Link("青空文庫FAQ", destination: url)
                    }
                    if let url = URL(string: "https://www.aozora.gr.jp/guide/kijyunn.html") {
                        Link("青空文庫ファイル取り扱い規準", destination: url)
                    }
                }
                Section() {
                    if let url = URL(string: "https://www.satokazzz.com/airzoshi/") {
                        Link("えあ草子ホームページ", destination: url)
                    }
                    if let url = URL(string: "https://www.satokazzz.com/doc/%E3%81%88%E3%81%82%E8%8D%89%E7%B4%99%E3%83%9E%E3%83%8B%E3%83%A5%E3%82%A2%E3%83%AB") {
                        Link("えあ草子マニュアル", destination: url)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("")
                }
            }
            .scrollContentBackground(.hidden)
            .modifier(BackgroundColorModifier())
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
