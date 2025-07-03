//
//  MemoryGame.swift
//  Memory
//  This is a Model
//  "Model" <-> ViewModel <-> View
//
//  Created by 黒木朝陽 on 7/1/25.
//

import Foundation

// <CardContent> is the Generics Type
struct MemoryGame<CardContent>   {
    private(set) var cards: [Card]  // setting the variable is private. reading is public
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    func choose(_ card: Card){
        
    }
    
    // Any function that mutates needs a mutating keyword
    mutating func shuffle() {
        cards.shuffle()
    }
     
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
