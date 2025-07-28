//
//  EmojiArt.swift
//  EmojiArt
//  This is our Model
//  "Model" <-> ViewModel <-> View
//  Created by 黒木朝陽 on 7/28/25.
//

import Foundation

/// This is our model
struct EmojiArt {
    var background: URL?
    private(set) var emojis = [Emoji]()
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ emoji: String, at position: Emoji.Position, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(
            id: uniqueEmojiId,
            string: emoji,
            position: position,
            size: size))
    }
    
    struct Emoji: Identifiable {
        var id: Int
        let string: String
        var position: Position
        var size: Int
        
        struct Position {
            var x: Int
            var y: Int
            
            // static variable can be accessed as Position.variableName
            static let zero = Self(x: 0, y: 0)
        }
    }
}
