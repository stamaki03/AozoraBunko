//
//  SelectionView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct SelectionView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            BookShelfView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("本棚")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
            RankingView()
                .tabItem {
                    Image(systemName: "crown")
                    Text("ランキング")
                }
            MenuView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("メニュー")
                }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
