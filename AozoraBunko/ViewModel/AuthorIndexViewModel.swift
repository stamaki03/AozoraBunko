//
//  AuthorIndexViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import Foundation

class AuthorIndexViewModel: ObservableObject {
    var authorIndex: [AuthorIndexItem] {
        return AuthorIndex.authorIndex
    }
}
