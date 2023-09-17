//
//  RandomBookSearchView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct RandomBookSearchView: View {
    @ObservedObject var randomBookSearchViewModel = RandomBookSearchViewModel()
    
    var body: some View {
        VStack {
            Button {
                randomBookSearchViewModel.findBookRandomly()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .modifier(RoundedButtonModifier(title: "ランダム検索"))
            }
            Spacer()
            Text(randomBookSearchViewModel.bookName)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
            Text(randomBookSearchViewModel.authorName)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
            Spacer()
            Button {
                randomBookSearchViewModel.saveData()
                randomBookSearchViewModel.openWebBookPage()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .modifier(RoundedButtonModifier(title: "読む"))
            }
            Spacer()
        }
        .onAppear {
            randomBookSearchViewModel.findBookRandomly()
        }
        .modifier(BackgroundColorModifier())
    }
}

struct RandomBookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RandomBookSearchView()
    }
}
