////
////  hw1.swift
////  demo-app
////
////  Created by 黒木朝陽 on 3/5/25.
////
//
//
//import SwiftUI
//// EmojiMemoryGameView is a name
//// struct ContentView: X
//// X mean 'Behaves' like X
//// @State means pointer -> makes it mutable (the stuff it's poing at can change)
//struct hw1: View {
//    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
//    let faceEmojis: [String] = ["😎", "😝", "😜", "🤩", "😍", "😎", "😝", "😜", "🤩", "😍"]
//    let countryEmojis: [String] = ["🇯🇵", "🇺🇸", "🇸🇬", "🇰🇷", "🇩🇪", "🇬🇧", "🇯🇵", "🇺🇸", "🇸🇬", "🇰🇷", "🇩🇪", "🇬🇧"]
//    let sportsEmojis: [String] = ["⚽️", "🏈", "🏀", "⚾️", "🏐", "🥊", "🏋️‍♂️", "⚽️", "🏈", "🏀", "⚾️", "🏐", "🥊", "🏋️‍♂️"]
//    var emojis: [[String]] {
//        [faceEmojis, countryEmojis, sportsEmojis]
////    }
//    @State var emojiId = 0
//    var body: some View {
//        VStack {
//            Text("Memorize!").font(.largeTitle)
//            ScrollView {
//                cards
//            }
//            themeAdjuster
//        }
//    }
//    var cards: some View {
//        let shuffledEmojis = emojis[emojiId].shuffled()
//        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
//            ForEach(shuffledEmojis.indices, id: \.self) {
//                index in
//                CardView(content: shuffledEmojis[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//            }
//        }
//        .foregroundStyle(.orange)
//        .padding()
//    }
//    
//    func themeAdjuster(themeId: Int, theme: String, symbol: String) -> some View {
//         VStack {
//             Button(action: {
//                 emojiId = themeId
//                 print("ID is: ", emojiId)
//             }, label: {
//                 Image(systemName: symbol)
//                     .imageScale(.large)
//                     .font(.largeTitle)
//             })
//             Text(theme).font(.body).foregroundStyle(Color.blue)
//         }
//    }
//    var faceTheme: some View {
//        themeAdjuster(themeId: 0, theme: "face", symbol: "face.smiling")
//    }
//    var sportsTheme: some View {
//        themeAdjuster(themeId: 1, theme: "sports", symbol: "figure.run.circle")
//    }
//    var countryTheme: some View {
//        themeAdjuster(themeId: 2, theme: "country", symbol: "flag")
//    }
//    var themeAdjuster: some View {
//        HStack {
//            faceTheme
//            Spacer()
//            sportsTheme
//            Spacer()
//            countryTheme
//        }
//        .padding()
//    }
//}
//
//// Views are immutable
//struct CardView: View {
//    let card: MemoryGame<String>.Card
//
//    var body: some View {
//        ZStack {
//            let base = RoundedRectangle(cornerRadius: 12)
//            Group {
//                base
//                    .foregroundStyle(.white)
//                base
//                    .strokeBorder(lineWidth: 5)
//                Text(card.content).font(.largeTitle)
//            }
//            .opacity(card.isFaceUp ? 1 : 0)
//            base.fill().opacity(card.isFaceUp ? 0 : 1)
//        }
//        .onTapGesture {
//            isFaceUp.toggle()
//        }
//    }
//}
//#Preview {
//    hw1()
//}
