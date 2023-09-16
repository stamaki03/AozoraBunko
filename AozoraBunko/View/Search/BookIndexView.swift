//
//  BookIndexView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct BookIndexView: View {
    @ObservedObject private var bookIndexViewModel = BookIndexViewModel()
    
    var body: some View {
        List {
            ForEach(bookIndexViewModel.bookIndex) { initial in
                Section(header: Text(initial.header)) {
                    ForEach(initial.lines) { lines in
                        NavigationLink(destination: BookListView(booksInfo: lines)) {
                            Text(lines.name)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct BookIndexView_Previews: PreviewProvider {
    static var previews: some View {
        BookIndexView()
    }
}
