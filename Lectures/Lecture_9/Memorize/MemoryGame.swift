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
    private(set) var score = 0
    
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
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatch].bonus
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatch].hasBeenSeen {
                            score -= 1
                        }
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
        
        // this is property observers: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Observers
        var isFaceUp = false {
            // didset is called immediately after the new value is stored
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                // oldValue refers to the value of isFaceUp before it was changed.
                // if the card was faced up but now it is facedown
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        let content: CardContent
        var id: String
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
