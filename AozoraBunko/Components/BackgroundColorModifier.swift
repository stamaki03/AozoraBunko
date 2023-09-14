//
//  BackgroundColorModifier.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(
                gradient: Gradient(colors: [Color("bg1"),Color("bg2")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
    }
}
