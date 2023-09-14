//
//  BookShelfView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct BookShelfView: View {
    var body: some View {
        Text("BookShelfView")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                gradient: Gradient(colors: [Color("bg1"),Color("bg2")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
    }
}

struct BookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfView()
    }
}
