//
//  ReadingBookView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import SwiftUI
import RealmSwift

struct ReadingBookView: View {
    @ObservedObject private var readingBookViewModel = ReadingBookViewModel()
        
    var body: some View {
        VStack {
            List {
                Text("読書中の本")
                    .font(.subheadline)
                ForEach(readingBookViewModel.books.freeze()) { value in
                    HStack {
                        VStack {
                            Link(value.book, destination: URL(string: "https://www.satokazzz.com/airzoshi/reader.php?action=aozora&id=\(value.cardNo)")!)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text(value.author)
                                Text("作品No.\(value.cardNo)")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Image(systemName: "chevron.backward")
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            readingBookViewModel.moveDataToFinishedReadingBook(value)
                        } label: {
                            Text("読了")
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            readingBookViewModel.deleteData(value.id)
                        } label: {
                            Text("削除")
                        }
                    }
                    
                }
                .onMove(perform: readingBookViewModel.moveData)
            }
        }
        .toolbar {
            EditButton()
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct ReadingBookView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBookView()
    }
}
