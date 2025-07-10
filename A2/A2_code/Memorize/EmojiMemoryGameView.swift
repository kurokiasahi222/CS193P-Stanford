//
//  EmojiMemoryGameView.swift
//  Memorize
//  This is a View
//  Model <-> ViewModel <-> "View"
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

/*
 "View" means behaves like a View (Protocol): requires "body" computed property
 When defining a custom view, it requires a "body"; however, things like
 VStack, Image, Text are builtin Views, thus dont require a body
 "some" is a opaque type -> body type conforms to View, but the exact type
 depends on the body's content
 ex) Text is a struct that conforms to View
 Views are immutable
 */

// Main View
struct EmojiMemoryGameView: View {
    // EmojiMemoryGame is a class. Thus when we declare viewModel, it has a pointer to the object
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
                // swift will animate when the value changes
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]
        , spacing: 0) {
            //  id: \.self => use the thing itself as the id
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }.foregroundColor(.orange)
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
