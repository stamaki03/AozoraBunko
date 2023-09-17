//
//  RankingView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject var rankingViewModel = RankingViewModel()
    
    init() {
        rankingViewModel.findRankingContents()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<rankingViewModel.bookArray.count, id: \.self) { i in
                    HStack {
                        Text(String(i+1))
                            .padding()
                        VStack {
                            Text(rankingViewModel.bookArray[i])
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(rankingViewModel.authorArray[i])
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button {
                            rankingViewModel.saveData(i)
                            rankingViewModel.openBook(i)
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
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("")
                }
            }
            .scrollContentBackground(.hidden)
            .modifier(BackgroundColorModifier())
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
