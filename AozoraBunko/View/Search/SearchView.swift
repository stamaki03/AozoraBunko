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
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .modifier(RoundedButtonModifier())
                        Text("作家別検索")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                NavigationLink(destination: BookIndexView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .modifier(RoundedButtonModifier())
                        Text("作品別検索")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                NavigationLink(destination: RandomAuthorSearchView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .modifier(RoundedButtonModifier())
                        Text("ランダム作家別検索")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                NavigationLink(destination: RandomBookSearchView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .modifier(RoundedButtonModifier())
                        Text("ランダム作品別検索")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("")
                }
            }
            .modifier(BackgroundColorModifier())
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
