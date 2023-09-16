//
//  WebReader.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/15.
//

import SwiftUI

struct WebReader {
    @Environment(\.openURL) private var openURL
    func openBook(_ cardId: String) {
        let url = "https://www.satokazzz.com/airzoshi/reader.php?action=aozora&id=\(cardId)"
        guard let validURL = URL(string: url) else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(validURL)
    }
}
