//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 黒木朝陽 on 7/1/25.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: [Card]
    
    func choose(card: Card){
        
    }
     
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
