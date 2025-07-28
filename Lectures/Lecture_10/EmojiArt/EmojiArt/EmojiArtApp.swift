//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by 黒木朝陽 on 7/28/25.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    @State var defaultDocument = EmojiArtDocument()
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
        }
    }  
}
