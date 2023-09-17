//
//  AuthorsCardView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import SwiftUI

struct AuthorsCardView: View {
    let authorNo: String
    
    @ObservedObject private var authorCardViewModel = AuthorCardViewModel()
    
    var body: some View {
        VStack {
            Text(authorCardViewModel.authorName)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
            List {
                ForEach(0..<authorCardViewModel.cardNoArray.count, id: \.self) { i in
                    HStack {
                        VStack {
                            Text(authorCardViewModel.bookArray[i])
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(authorCardViewModel.bookInfoArray[i])
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button {
                            authorCardViewModel.saveData(i)
                            authorCardViewModel.openBook(i)
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
            .onAppear {
                authorCardViewModel.getAuthorNameArray(authorNo)
            }
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct AuthorCardView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorsCardView(authorNo: "34")
    }
}
