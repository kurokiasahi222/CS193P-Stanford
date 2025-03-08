
import SwiftUI
// EmojiMemoryGameView is a name
// struct ContentView: X
// X mean 'Behaves' like X
// @State means pointer -> makes it mutable (the stuff it's poing at can change)
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var emojiId = 0
    var body: some View {
        ScrollView {
            VStack {
                Text("MEMORY")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                .padding()
                HStack {
                    Text(viewModel.theme.name)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Spacer()
                    Text("Score: \(viewModel.getScore())")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        
                }.padding(.horizontal, 50)
                cards
                    .animation(.default, value: viewModel.cards)
                Button(action: {
                    viewModel.newGame()
                }, label: {
                        Text("Start a New Game!")
                        .font(.title)
                        
                })
                .padding()
            }
        }

    }
    var cards: some View {
        return LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80), spacing: 0)],
            spacing: 0
        )
        {
            ForEach(viewModel.cards) {
                card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .foregroundStyle(viewModel.theme.color)
        }
    }
}

// This represent a card
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .foregroundStyle(.white)
                base
                    .strokeBorder(lineWidth: 5)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
