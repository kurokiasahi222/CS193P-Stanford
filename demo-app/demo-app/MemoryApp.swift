//
//  MemoryApp.swift
//  MemoryApp
//
//  Created by 黒木朝陽 on 3/3/25.
//

import SwiftUI

@main
struct MemoryApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
