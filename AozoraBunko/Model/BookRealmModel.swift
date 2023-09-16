//
//  BookRealmModel.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation
import RealmSwift

final class BookRealmModel: ObservableObject {
    var config: Realm.Configuration
    
    init() {
        config = Realm.Configuration()
    }
    
    var realm: Realm {
        return try! Realm(configuration: config)
    }
    
    // 読書中の本の登録データ
    var readingBookItems: Results<ReadingBookItem> {
        realm.objects(ReadingBookItem.self)
    }
    
    // 読了した本の登録データ
    var finishedReadingBookItems: Results<FinishedReadingBookItem> {
        realm.objects(FinishedReadingBookItem.self)
    }
        
    func addData<T: BookItem> (_ itemToBeAdded: T) {
        try! realm.write {
            realm.add(itemToBeAdded)
        }
    }
    
    func deleteData<T: BookItem> (_ itemToBeRemoved: T) {
        try! realm.write {
            realm.delete(itemToBeRemoved)
        }
    }
    
    func moveData<T: BookItem> (_ offsets: IndexSet, _ index: Int, _ itemToBeMoved: T, _ tmpItem: T, _ bookItems: Results<T>) {
        try! realm.write {
            // リストの行を下に移動する場合
            if offsets.first! < index {
                // 移動先のデータを一時保存
                tmpItem.book = bookItems[index-1].book
                tmpItem.author = bookItems[index-1].author
                tmpItem.cardNo = bookItems[index-1].cardNo
                // 移動元のデータを移動先へ
                bookItems[index-1].book = itemToBeMoved.book
                bookItems[index-1].author = itemToBeMoved.author
                bookItems[index-1].cardNo = itemToBeMoved.cardNo
                // 移動元を起点に、次のデータを一つ前に移すことを移動先の一つ前まで繰り返す
                for i in (offsets.first!)..<index-1 {
                    bookItems[i].book = bookItems[i+1].book
                    bookItems[i].author = bookItems[i+1].author
                    bookItems[i].cardNo = bookItems[i+1].cardNo
                }
                // 移動先の一つ前のデータに一時保存データを挿入する
                bookItems[index-2].book = tmpItem.book
                bookItems[index-2].author = tmpItem.author
                bookItems[index-2].cardNo = tmpItem.cardNo
            // リストの行を上に移動する場合
            } else if index < offsets.first! {
                // 移動先のデータを一時保存
                tmpItem.book = bookItems[index].book
                tmpItem.author = bookItems[index].author
                tmpItem.cardNo = bookItems[index].cardNo
                // 移動元のデータを移動先へ
                bookItems[index].book = itemToBeMoved.book
                bookItems[index].author = itemToBeMoved.author
                bookItems[index].cardNo = itemToBeMoved.cardNo
                // 移動元を起点に、次のデータを一つ前に移すことを移動先の一つ前まで逆順にして繰り返す
                for i in (index..<(offsets.first!)).reversed() {
                    bookItems[i+1].book = bookItems[i].book
                    bookItems[i+1].author = bookItems[i].author
                    bookItems[i+1].cardNo = bookItems[i].cardNo
                }
                // 移動先の一つ前のデータに一時保存データを挿入する
                bookItems[index+1].book = tmpItem.book
                bookItems[index+1].author = tmpItem.author
                bookItems[index+1].cardNo = tmpItem.cardNo
            } else {
                return
            }
        }
    }
}
