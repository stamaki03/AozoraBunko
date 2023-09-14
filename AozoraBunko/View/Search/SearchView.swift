//
//  SearchView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct SearchView: View {
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: AuthorIndexView()) {
                    Text("作家別検索")
                        .modifier(RoundedButtonModifier())
                }
                NavigationLink(destination: BookIndexView()) {
                    Text("作品別検索")
                        .modifier(RoundedButtonModifier())
                }
                NavigationLink(destination: RandomAuthorSearchView()) {
                    Text("ランダム作家別検索")
                        .modifier(RoundedButtonModifier())
                }
                NavigationLink(destination: RandomBookSearchView()) {
                    Text("ランダム作品別検索")
                        .modifier(RoundedButtonModifier())
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("検索")
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
