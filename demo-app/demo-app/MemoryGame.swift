//
//  MemorizeGame.swift
//  Model part of MVVM
//  demo-app
//
//  Created by 黒木朝陽 on 3/4/25.
//

import Foundation
//<CardContent> is a anytime (I don't care)

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set): Only settings is private. Can be accessed by others
    private(set) var cards: [Card]
    private(set) var score = 0
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // addnumberOfPairs * 2
        for pairIndex in 0..<numberOfPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) | \(isFaceUp ? "Up" : "down") | \(isMatched ? "Matched" : "Not matched") | Previously Seen: \(previouslySeen)"
        }
        
        var isFaceUp = false
        var isMatched = false
        var previouslySeen = false
        let content: CardContent
        var id: String
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    var indexOfFaceUp: Int? {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    // This function is mutating because it changes the state of the struct
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            print("chosen index: \(chosenIndex)")
            // ignore if the card is already matched or face up
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfFaceUp {
                    print("potentialMatchIndex: \(potentialMatchIndex)")
                    // check if the cards match
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else if cards[chosenIndex].previouslySeen {
                        // check if the card has been seen before
                        score -= 1
                    }

                } else {
                    indexOfFaceUp = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].previouslySeen = true
                print(cards[chosenIndex])
                print("-----------------")
            }
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
