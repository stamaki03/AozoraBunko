//
//  FinishedReadingBookView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import SwiftUI
import RealmSwift

struct FinishedReadingBookView: View {
    @ObservedObject private var finishedReadingBookViewModel = FinishedReadingBookViewModel()
    
    var body: some View {
        List {
            Text("読了した本")
                .font(.subheadline)
            ForEach(finishedReadingBookViewModel.books.freeze()) { value in
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
                        finishedReadingBookViewModel.moveDataToReadingBook(value)
                    } label: {
                        Text("読書中")
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        finishedReadingBookViewModel.deleteData(value.id)
                    } label: {
                        Text("削除")
                    }
                }
            }
            .onMove(perform: finishedReadingBookViewModel.moveData)
        }
        .toolbar {
            EditButton()
        }
        .modifier(BackgroundColorModifier())
        .scrollContentBackground(.hidden)
    }
}

struct FinishedReadingBookView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedReadingBookView()
    }
}
