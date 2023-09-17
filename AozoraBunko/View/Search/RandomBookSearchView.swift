//
//  RandomBookSearchView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct RandomBookSearchView: View {
    @ObservedObject private var randomBookSearchViewModel = RandomBookSearchViewModel()
    @State private var randomButtonState = false
    
    var body: some View {
        VStack {
            Button {
                randomButtonState = true
                randomBookSearchViewModel.findBookRandomly()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    randomButtonState = false
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .modifier(RoundedButtonModifier(title: "ランダム検索"))
            }
            .disabled(randomButtonState ? true : false)
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
