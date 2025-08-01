//
//  EmojiArtDocument.swift
//  EmojiArt
//  This is our ViewModel
//  Model <-> "ViewModel" <-> View
//  Created by 黒木朝陽 on 7/28/25.
//

import SwiftUI


/// This is our ViewModel
@Observable
class EmojiArtDocument {
    typealias Emoji = EmojiArt.Emoji
    private var emojiArt = EmojiArt()
    
    init() {
        emojiArt.addEmoji("👻", at: .init(x: -200, y: -150), size: 80)
        emojiArt.addEmoji("🍎", at: .init(x: 0, y: 0), size: 80)
    }
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK: - Intent(s)
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }
}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry : GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y -  CGFloat(y))
    }
}
