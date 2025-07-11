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
    typealias card = MemoryGame<String>.Card
    var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.Color)
            HStack {
                score
                shuffleButton
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation(.default) {
                viewModel.shuffle()
            }
        }
    }
    
    private let spacing: CGFloat = 4
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    private func scoreChange (causedBy card: card) -> Int {
        return 0
    }
 
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
