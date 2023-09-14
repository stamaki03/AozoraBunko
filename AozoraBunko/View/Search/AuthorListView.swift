//
//  AuthorListView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct AuthorListView: View {
    let url: String
    
    var body: some View {
        Text("`\(url)")
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorListView(url: "https://www.aozora.gr.jp/index_pages/person_wa.html")
    }
}
