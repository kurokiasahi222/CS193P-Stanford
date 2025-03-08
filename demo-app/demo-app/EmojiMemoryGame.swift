//
//  EmojiMemoryGame.swift
//  demo-app
//  View-Model part of MVVM
//  This is the gate-keeper
//  Created by 黒木朝陽 on 3/4/25.
//
import SwiftUI

protocol Theme {
    var name: String { get }
    var emojis: [String] { get }
    var numberOfPairs: Int { get }
    var color: Color { get }
    
}
private struct FaceEmojis: Theme {
    var name = "Face"
    var emojis = ["😎", "😝", "😜", "🤩", "😍"]
    var numberOfPairs = 7
    var color = Color.blue
}

private struct CountryEmojis: Theme {
    var name = "Country"
    var emojis = ["🇯🇵", "🇺🇸", "🇸🇬", "🇰🇷", "🇩🇪", "🇬🇧"]
    var numberOfPairs = 7
    var color = Color.green
}

private struct SportsEmojis: Theme {
    var name = "Sports"
    var emojis = ["⚽️", "🏈", "🏀", "⚾️", "🏐", "🥊", "🏋️‍♂️"]
    var numberOfPairs = 7
    var color = Color.red
}

private struct FruitsEmojis: Theme {
    var name = "Fruits"
    var emojis = ["🍎", "🍐", "🍊", "🍋"]
    var numberOfPairs = 6
    var color = Color.orange
}

private struct AnimalsEmojis: Theme {
    var name = "Animals"
    var emojis = ["🐶", "🐱", "🐷", "🦁", "🐨", "🐼"]
    var numberOfPairs = 4
    var color = Color.yellow
}

private struct DinnnerEmojis: Theme {
    var name = "Dinner"
    var emojis = ["🍔", "🍟", "🍕", "🌮", "🍜", "🥪", "🥩"]
    var numberOfPairs = 5
    var color = Color.purple
}

// ObservableObject
class EmojiMemoryGame: ObservableObject {
    private static var themes: [Theme] = [FaceEmojis(), CountryEmojis(), SportsEmojis(), FruitsEmojis(), AnimalsEmojis(), DinnnerEmojis()]
    
    @Published private var model: MemoryGame<String>
    @Published private(set) var theme: Theme  // only setting is private
    
    init() {
        let (game, theme) = EmojiMemoryGame.createMemoryGame()
        self.model = game
        self.theme = theme
    }
    
    private static func createMemoryGame() -> (MemoryGame<String>, Theme) {
        let randomTheme = themes.randomElement()!
        let game =  MemoryGame(numberOfPairs: randomTheme.numberOfPairs) { index in
            if randomTheme.emojis.indices.contains(index) {
                return randomTheme.emojis[index]
            } else {
                // pick a rondom emoji from the theme
                return randomTheme.emojis.shuffled().first!
            }
        }
        return (game, randomTheme)
    }

    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards 
    }
    
    func getScore() -> Int{
        model.getScore()
    }
    
    func newGame() {
        let (game, theme) = EmojiMemoryGame.createMemoryGame()
        self.model = game
        self.theme = theme
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
