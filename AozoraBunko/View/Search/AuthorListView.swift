//
//  AuthorListView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct AuthorListView: View {
    let url: String
    
    @ObservedObject private var authorListViewModel = AuthorListViewModel()
    
    var body: some View {
        List {
            ForEach(authorListViewModel.searchResults, id: \.self) { i in
                NavigationLink(destination: AuthorsCardView(authorNo: authorListViewModel.authorNoArray[i])) {
                    Text(authorListViewModel.authorArray[i])
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .onAppear {
            authorListViewModel.getAuthorNameArray(url)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        }
        .searchable(text: $authorListViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorListView(url: "https://www.aozora.gr.jp/index_pages/person_wa.html")
    }
}
