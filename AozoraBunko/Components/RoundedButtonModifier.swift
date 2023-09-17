//
//  RoundedButtonModifier.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/17.
//

import SwiftUI

struct RoundedButtonModifier: ViewModifier {
    
    let title: String
    
//    init(title: String) {
//        self.title = title
//    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 80)
            .foregroundColor(.white.opacity(0))
            .background(.white)
            .cornerRadius(20)
            .overlay(
                ZStack {
                    Text(title)
                        .foregroundColor(.black)
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 0.5)
                    
                }
            )
            .padding()
    }
}
