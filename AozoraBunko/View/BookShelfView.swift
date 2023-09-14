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
            .background(Color("bg"))
    }
}

struct BookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfView()
    }
}
