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
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]  // setting the variable is private. reading is public
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
//            cardContentFactory is
//            index in
//                if emojis.indices.contains(index) {
//                    return emojis[index]
//                } else {
//                       return "?"
//                }
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter  { index in cards[index].isFaceUp }
            return faceUpCardIndices.only
        }
        set (chosenIndex) {
            return cards.indices.forEach { cards[$0].isFaceUp = (chosenIndex == $0) }
        } 
    }
     
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatch = indexOfTheOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatch].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatch].isMatched = true
                    }
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    func index(_ card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    // Any function that mutates needs a mutating keyword
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
     
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var description: String {
            return "\(id): \(content) \(isFaceUp ? "👆" : "👇") \(isMatched ? "✅" : "")"
        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
