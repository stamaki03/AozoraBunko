//
//  BookRealmItem.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation
import RealmSwift

protocol BookItem: Object, ObjectKeyIdentifiable, Identifiable {
    var id: UUID { get set }
    var book: String { get set }
    var author: String { get set }
    var cardNo: String { get set }
}

// BookShelfView(本棚)配下にReadingBook(読書中の本)として出力される情報
final class ReadingBookItem: Object, ObjectKeyIdentifiable, Identifiable, BookItem {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var book: String
    @Persisted var author: String
    @Persisted var cardNo: String
}

// BookShelfView(本棚)配下にFinishedReadingBook(読了した本)として出力される情報
final class FinishedReadingBookItem: Object, ObjectKeyIdentifiable, Identifiable, BookItem {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var book: String
    @Persisted var author: String
    @Persisted var cardNo: String
}
