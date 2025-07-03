//
//  File.swift
//  Memorize
//  This is a ViewModel
//  Model <-> "ViewModel" <-> View
//  Created by 黒木朝陽 on 7/1/25.
//

import SwiftUI


// Our ViewModel will actually create the Game based on the logic
// of our Model. This is a example of Observer Design Pattern, where
// observable object or Publisher maintain a list of observers and notify
// them of specific or general state changes.
@Observable class EmojiMemoryGame {
    // static = Type Properties -> "Global" for this namespace
    // static let emojis = EmojiMemoryGame.emojis
    private static let emojis = ["👻", "🎃", "🕷️", "🦇", "🍬", "🧙‍♀️", "🕸️", "🧛‍♂️", "🕯️", "🍭"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 6) {index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "?"
            }
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
      
}
     

