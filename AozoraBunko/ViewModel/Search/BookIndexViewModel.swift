//
//  BookIndexViewModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/16.
//

import Foundation

final class BookIndexViewModel: ObservableObject {
    var bookIndex: [BookIndexItem] {
        return BookIndex.bookIndex
    }
}
