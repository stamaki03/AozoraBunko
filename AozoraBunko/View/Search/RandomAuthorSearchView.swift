//
//  RandomAuthorSearchView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct RandomAuthorSearchView: View {
    @ObservedObject var randomAuthorSearchViewModel = RandomAuthorSearchViewModel()
    
    var body: some View {
        VStack {
            Button {
                randomAuthorSearchViewModel.findAuthorRandomly()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .modifier(RoundedButtonModifier(title: "ランダム検索"))
            }
            Text(randomAuthorSearchViewModel.authorName)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
            List {
                ForEach(0..<randomAuthorSearchViewModel.cardNoArray.count, id: \.self) { i in
                    HStack {
                        VStack {
                            Text(randomAuthorSearchViewModel.bookArray[i])
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(randomAuthorSearchViewModel.bookInfoArray[i])
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button {
                            randomAuthorSearchViewModel.saveData(i)
                            randomAuthorSearchViewModel.openBook(i)
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
            randomAuthorSearchViewModel.findAuthorRandomly()
        }
        .scrollContentBackground(.hidden)
        .modifier(BackgroundColorModifier())
    }
}

struct RandomAuthorSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RandomAuthorSearchView()
    }
}
