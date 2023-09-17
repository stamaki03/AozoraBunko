//
//  AuthorIndexView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct AuthorIndexView: View {
    @ObservedObject private var authorIndexViewModel = AuthorIndexViewModel()
    
    var body: some View {
        List {
            ForEach(authorIndexViewModel.authorIndex) { initial in
                NavigationLink(destination: AuthorListView(url: initial.url)) {
                    Text(initial.name)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct AuthorIndexView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorIndexView()
    }
}
