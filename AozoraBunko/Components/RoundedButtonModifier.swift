//
//  RoundedButtonModifier.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct RoundedButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 80)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 0.5)
            )
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 10, y: 10)
            .padding()
    }
}
