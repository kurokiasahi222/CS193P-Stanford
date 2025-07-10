//
//  EmojiMemoryGameView.swift
//  Memorize
//  This is a View
//  Model <-> ViewModel <-> "View"
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

// Main View
struct EmojiMemoryGameView: View {
    // EmojiMemoryGame is a class. Thus when we declare viewModel, it has a pointer to the object
    var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    var body: some View {
        VStack{
            cards
                .foregroundColor(viewModel.Color)
                .animation(.default, value: viewModel.cards)
            // swift will animate when the value changes
            Button("Shuffle") {
                viewModel.shuffle()
            }  
        }
        .padding()
        
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
 
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
