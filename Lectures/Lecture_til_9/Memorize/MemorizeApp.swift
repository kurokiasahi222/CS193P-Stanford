//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
