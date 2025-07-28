//
//  EmojiArtDocumentView.swift
//  EmojiArt
//  This is our View
//  Model <-> ViewModel <-> "View"
//  Created by 黒木朝陽 on 7/28/25.
//

import SwiftUI

/// This is our View in MVVM
struct EmojiArtDocumentView: View {
    typealias Emoji = EmojiArt.Emoji
    private let emojis = "👻🍎😃🤪☹️🤯🐶🐭🦁🐵🦆🐝🐢🐄🐖🌲🌴🌵🍄🌞🌎🔥🌈🌧️🌨️☁️⛄️⛳️🚗🚙🚓🚲🛺🏍️🚘✈️🛩️🚀🚁🏰🏠❤️💤⛵️"
    let defaultBackgroundURL = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fcartoon-background-rolling-hills&psig=AOvVaw32reeJWxG_dgNhKjgBF9V9&ust=1753771833141000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCJiK5a373o4DFQAAAAAdAAAAABAE"
    private let emojiSize: CGFloat = 40  
    var document: EmojiArtDocument
    
    var body: some View {
        VStack (spacing: 0) {
            documentBody
            ScrollingEmojis(emojis)
                .font(.system(size: emojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
    }
    
    private var documentBody: some  View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                AsyncImage(url: document.background)
                    .position(Emoji.Position.zero.in(geometry))
                ForEach(document.emojis) { emoji in
                    Text(emoji.string)
                        .font(emoji.font)
                        .position(emoji.position.in(geometry))
                }
            }
            .dropDestination(for: Sturldata.self) { sturldata, location in
                return drop(sturldata, at: location, in: geometry)
            }
        }
    }
    
    private func drop(_ sturldatas: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        for sturldata in sturldatas {
            switch sturldata {
            case .url(let url):
                document.setBackground(url)
                return true
            case .string(let emoji):
                document.addEmoji(emoji,
                                  at: emojiPosition(location, in: geometry),
                                  size: emojiSize)
                return true 
            default:
                break
            }
        }
        return false
    }
    
    private func emojiPosition(_ location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(
            x: Int(location.x - center.x),
            y: -Int(location.x - center.x)
            )
    }
}


/// This is a scrollable list of Emojis user can select and drag to the main panel
struct ScrollingEmojis: View {
    let emojis: [String]
    
    init(_ emojis: String) {
        self.emojis = emojis.uniqued.map(String.init)
    }
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .draggable(emoji)
                }
            }
        }
    }
}

#Preview {
    EmojiArtDocumentView(document: EmojiArtDocument())
}
