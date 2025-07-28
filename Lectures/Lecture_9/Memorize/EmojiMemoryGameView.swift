//
//  EmojiMemoryGameView.swift
//  Memorize
//  This is a View
//  Model <-> ViewModel <-> "View"
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

/// View of the MVVM architecture. Responsible for showing the UI.
struct EmojiMemoryGameView: View {
    typealias card = MemoryGame<String>.Card
    var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.Color)
            HStack {    
                score
                Spacer()
                deck.foregroundColor(viewModel.Color)
                Spacer()
                shuffleButton
            }
        }
        .padding()
    }
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1: 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
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
    /// State Tuple responsible for keeping track of the change in the score
    /// as well as what card caused the change. The amount change is used
    /// for the animation.
    /// +x when user gets the correct answer, -x when user get the wrong answer, where x = change
    @State private var lastScoreChange = (0, causedByCardId: "")
    /// Called when the user touches a card. Changes the state variable
    /// "lastScoreChange" based on the change in the score.
    private func choose(_ card: card) {
        withAnimation(.default) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    private func scoreChange (causedBy card: card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    @State private var dealt = Set<Card.ID>()
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var unDeaultCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    private let deckWith: CGFloat = 50
    
    @Namespace private var dealingNamespace
    private var deck: some View {
        ZStack {
            ForEach(unDeaultCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWith, height: deckWith / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.spring(duration: 1).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.05
        }
    }
 
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
