//
//  TextParser.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import Foundation
import Kanna

// htmlから必要な情報を抜き出す
struct TextParser {
    // AuthorListViewModel(著者検索)ページ用
    func forAuthorList(_ html: String) -> ([String], [String]) {
        var authorArray: [String] = []
        var authorNoArray: [String] = []
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // liタグの要素の中身を取得(著者名のリストを取得)
            var tmpAuthorArray: [String] = []
            for value in doc.xpath("//li") {
                guard let text = value.text else { continue }
                tmpAuthorArray.append(text)
            }
            authorArray = tmpAuthorArray
            // aタグ内のhref属性の属性値を取得
            var tmpDataArray: [String] = []
            var tmpAuthorInfoArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpDataArray.append(text)
            }
            tmpAuthorInfoArray = tmpDataArray.filter({ $0.contains("sakuhin_list") })
            // 上で取得した情報から著者Noのリストを取得
            var tmpAuthorNoArray: [String] = []
            for str in tmpAuthorInfoArray {
                let tmpArray = str.components(separatedBy: ".")
                tmpAuthorNoArray.append(String(tmpArray[0].dropFirst(6)))
            }
            authorNoArray = tmpAuthorNoArray
        }
        return (authorArray, authorNoArray)
    }
    
    // AuthorCardViewModel(著者作品リスト)ページ用
    func forAuthorCard(_ html: String) -> ([String], [String], String, [String]) {
        var cardNoArray: [String] = []
        var bookArray: [String] = []
        var authorName: String = ""
        var bookInfoArray: [String] = []
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // aタグ内のhref属性の属性値を取得
            var tmpDataArray: [String] = []
            var tmpPathArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpDataArray.append(text)
            }
            tmpPathArray = tmpDataArray.filter({ $0.contains("cards") })
            // 上で取得した情報から作品Noのリストを取得
            var tmpCardNoArray: [String] = []
            for str in tmpPathArray {
                let tmpArray = str.components(separatedBy: "/")
                tmpCardNoArray.append(String(tmpArray[3].dropFirst(4).dropLast(5)))
            }
            cardNoArray = tmpCardNoArray
            // aタグ内で属性値にcardsが含まれているhref属性の中身を取得(作品名のリストを取得)
            var tmpBookArray: [String] = []
            for value in doc.xpath("//a[contains(@href,'cards')]") {
                guard let text = value.text else { continue }
                tmpBookArray.append(text)
            }
            bookArray = tmpBookArray
            // titleタグの要素を取得(著者名のリストを取得)
            var tmpAuthorArray: [String] = []
            for value in doc.xpath("//title") {
                guard let text = value.text else { continue }
                tmpAuthorArray.append(text)
            }
            authorName = String(tmpAuthorArray[0].dropFirst(9))
            // aタグ内で属性値にcardsが含まれているhref属性の親要素(liタグ)の中身を取得(作品情報のリストを取得)
            var tmpBookInfoArray: [String] = []
            for value in doc.xpath("//a[contains(@href,'cards')]/parent::li/text()") {
                guard let text = value.text else { continue }
                let result = text.replacingOccurrences(of:"→", with:"").replacingOccurrences(of:"　", with:"")
                tmpBookInfoArray.append(result)
            }
            bookInfoArray = tmpBookInfoArray.filter({ $0.contains("作品ID") })
        }
        return (cardNoArray, bookArray, authorName, bookInfoArray)
    }
    
    // BookListViewModel(本検索)ページ用
    func forBookList(_ html: String) -> Int {
        var num: Int = 1
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // aタグ内のhref属性の属性値を取得(ページ数に関するリストを取得)
            var tmpPageArray: [String] = []
            var pageArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpPageArray.append(text)
            }
            pageArray = tmpPageArray.filter({ $0.contains("sakuhin_") })
            // 上で取得したリストに情報が存在すればページ数を取得する(存在しなければ処理は行わず、初期値の1をそのまま返す)
            var tmpPageInfo: String = ""
            if !(pageArray.isEmpty) {
                tmpPageInfo = pageArray.dropLast(1).last!
                let splitNumbers = (tmpPageInfo.components(separatedBy: NSCharacterSet.decimalDigits.inverted))
                let number = splitNumbers.joined()
                num = Int(number)!
            }
        }
        return num
    }
    
    // BookListViewModel(本検索)ページ用(2回目)
    func forBookList2(_ html: String) -> ([String]?, [String]?, [String]?, [String]?) {
        var bookArray: [String]?
        var bookInfoArray: [String]?
        var authorArray: [String]?
        var cardNoArray: [String]?
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // bodyタグの要素を取得、"データが見つかりません"が含まれている場合nilを返す
            var dataCheckArray: [String] = []
            for value in doc.xpath("//body") {
                guard let text = value.text else { continue }
                dataCheckArray.append(text)
            }
            let dataCheck: [String]? = dataCheckArray.filter({ $0.contains("データが見つかりません") })
            if (dataCheck?.isEmpty) == false {
                return (nil, nil, nil, nil)
            }
            // tdタグ内のvalign属性がtopの中身を取得
            var tmpDataArray: [String] = []
            var tmpInfoArray: [[String]] = []
            for value in doc.xpath("//td[@valign='top']") {
                guard let text = value.text else { continue }
                let result = text.replacingOccurrences(of:"\n", with:"").replacingOccurrences(of:" ", with:"")
                if tmpDataArray.count < 5 {
                    tmpDataArray.append(result)
                } else {
                    tmpDataArray.append(result)
                    tmpInfoArray.append(tmpDataArray)
                    tmpDataArray.removeAll()
                }
            }
            tmpInfoArray.removeFirst()
            // 上で取得した情報から作品名・作品情報・著者名のリストを取得
            var tmpBookArray: [String] = []
            var tmpBookInfoArray: [String] = []
            var tmpAuthorArray: [String] = []
            for value in tmpInfoArray {
                tmpBookArray.append(value[1])
                tmpBookInfoArray.append(value[2])
                tmpAuthorArray.append(value[3])
            }
            bookArray = tmpBookArray
            bookInfoArray = tmpBookInfoArray
            authorArray = tmpAuthorArray
            // aタグ内のhref属性の属性値を取得
            var tmpItemArray: [String] = []
            var tmpPathArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpItemArray.append(text)
            }
            tmpPathArray = tmpItemArray.filter({ $0.contains("cards") })
            // 上で取得した情報から作品Noのリストを取得
            var tmpString: String = ""
            var tmpCardNoArray: [String] = []
            for str in tmpPathArray {
                let tmpArray = str.components(separatedBy: "/")
                tmpString = String(tmpArray[3].dropFirst(4).dropLast(5))
                tmpCardNoArray.append(tmpString)
            }
            cardNoArray = tmpCardNoArray
        }
        return (bookArray, bookInfoArray, authorArray, cardNoArray)
    }
    
    // RandomAuthorSearchViewModel(ランダム著者検索)ページ用
    func forRandomAuthorSearch(_ html: String) -> [String] {
        var authorNoArray: [String] = []
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // aタグ内のhref属性の属性値を取得(著者Noを取得)
            var tmpDataArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpDataArray.append(text)
            }
            authorNoArray = tmpDataArray.filter({ $0.contains(".html#sakuhin_list_1") })
        }
        return authorNoArray
    }
    
    // RandomAuthorSearchViewModel(ランダム著者検索)ページ用(2回目)
    func forRandomAuthorSearch2(_ html: String) -> ([String], [String], String, [String]) {
        var cardNoArray: [String] = []
        var bookArray: [String] = []
        var authorName: String = ""
        var bookInfoArray: [String] = []
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // aタグ内のhref属性の属性値を取得
            var tmpDataArray: [String] = []
            var tmpPathArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpDataArray.append(text)
            }
            tmpPathArray = tmpDataArray.filter({ $0.contains("cards") })
            // 上で取得した情報から作品Noのリストを取得
            var tmpCardNoArray: [String] = []
            for str in tmpPathArray {
                let tmpArray = str.components(separatedBy: "/")
                tmpCardNoArray.append(String(tmpArray[3].dropFirst(4).dropLast(5)))
            }
            cardNoArray = tmpCardNoArray
            // aタグ内で属性値にcardsが含まれているhref属性の中身を取得(作品名のリストを取得)
            var tmpBookArray: [String] = []
            for value in doc.xpath("//a[contains(@href,'cards')]") {
                guard let text = value.text else { continue }
                tmpBookArray.append(text)
            }
            bookArray = tmpBookArray
            // titleタグの要素を取得(著者名を取得)
            var tmpAuthorArray: [String] = []
            for value in doc.xpath("//title") {
                guard let text = value.text else { continue }
                tmpAuthorArray.append(text)
            }
            authorName = String(tmpAuthorArray[0].dropFirst(9))
            // aタグ内で属性値にcardsが含まれているhref属性の親要素(liタグ)の中身を取得(作品情報のリストを取得)
            var tmpBookInfoArray: [String] = []
            for value in doc.xpath("//a[contains(@href,'cards')]/parent::li/text()") {
                guard let text = value.text else { continue }
                let tmpArray = text.replacingOccurrences(of:"→", with:"").replacingOccurrences(of:"　", with:"")
                tmpBookInfoArray.append(tmpArray)
            }
            bookInfoArray = tmpBookInfoArray.filter({ $0.contains("作品ID") })
        }
        return (cardNoArray, bookArray, authorName, bookInfoArray)
    }
    
    // RankingViewModel(ランキングページ)用
    func forRanking(_ html: String) -> ([String], [String], [String]) {
        var bookArray: [String] = []
        var authorArray: [String] = []
        var cardNoArray: [String] = []
        
        if let doc = try? HTML(html: html, encoding: .utf8) {
            // tdタグ内のclass属性がnormalの中身を取得(作品名・著者名のリストを取得)
            var tmpDataArray: [String] = []
            for value in doc.xpath("//td[@class='normal']") {
                guard let text = value.text else { continue }
                let modifiedText = text.replacingOccurrences(of:"\n", with:"").replacingOccurrences(of:"　", with:"").replacingOccurrences(of:" ", with:"")
                if tmpDataArray.count < 3 {
                    tmpDataArray.append(modifiedText)
                } else {
                    tmpDataArray.append(modifiedText)
                    bookArray.append(tmpDataArray[1])
                    authorArray.append(tmpDataArray[2])
                    // rankingDataArray.append(tmpDataArray)
                    tmpDataArray.removeAll()
                }
            }
            // aタグ内のhref属性の属性値を取得
            var tmpPathArray: [String] = []
            for value in doc.xpath("//a/@href") {
                guard let text = value.text else { continue }
                tmpPathArray.append(text)
            }
            let tmpModifiedPathArray = tmpPathArray.filter({ $0.contains("cards") })
            // 上で取得した情報から作品Noのリストを取得
            for str in tmpModifiedPathArray {
                let tmpArray: [String]
                let urlInfo: String
                tmpArray = str.components(separatedBy: "/")
                urlInfo = String(tmpArray[5].dropFirst(4).dropLast(5))
                cardNoArray.append(urlInfo)
            }
        }
        return (bookArray, authorArray, cardNoArray)
    }
}
