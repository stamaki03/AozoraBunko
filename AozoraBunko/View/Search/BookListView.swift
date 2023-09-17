//
//  BookListView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import SwiftUI

struct BookListView: View {
    let booksInfo: BookIndexLineItem
    
    @ObservedObject private var bookListViewModel = BookListViewModel()
    @State private var selectedNum = 1
    
    let columns : [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .center), count: 5)
    
    var body: some View {
        VStack {
            ScrollView() {
                LazyVGrid(columns: columns) {
                    ForEach((1...bookListViewModel.num), id: \.self) { i in
                        Button {
                            selectedNum = i
                            bookListViewModel.getBookNameArray(index: booksInfo.index, number: String(i))
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(selectedNum == i ? .gray : .white)
                                .frame(width: 50, height: 30)
                                .overlay(
                                    Text("\(i)")
                                        .foregroundColor(selectedNum == i ? .white : .black)
                                )
                        }
                    }
                }
            }
            .frame(height: 80)
            List {
                Text("ページ \(selectedNum)")
                    .font(.subheadline)
                ForEach(0..<bookListViewModel.bookArray.count, id: \.self) { i in
                    HStack {
                        VStack {
                            Text(bookListViewModel.bookArray[i])
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(bookListViewModel.authorArray[i])
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button {
                            bookListViewModel.saveData(i)
                            bookListViewModel.openBook(i)
                        } label: {
                            Text("読む")
                                .frame(width: 60, height: 30)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
        .onAppear {
            bookListViewModel.getPageNumber(url: booksInfo.url)
            bookListViewModel.getBookNameArray(index: booksInfo.index, number: "1")
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(booksInfo: BookIndexLineItem(name: "ろ", url: "https://www.aozora.gr.jp/index_pages/sakuhin_ro1.html", index: "ro"))
    }
}
