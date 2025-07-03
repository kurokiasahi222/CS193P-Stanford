//
//  ContentView.swift
//  Memorize
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

struct ContentView: View {
    static let faceEmojis = ["😁", "🥹", "😂", "😍", "😎", "🤩", "😭", "🤬", "🥶", "😱"]
    static let sportsEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉"]
    static let halloweenEmojis = ["👻", "🎃", "🕷️", "🦇", "🍬", "🧙‍♀️", "🕸️", "🧛‍♂️", "🕯️", "🍭"]
    let emojis = [faceEmojis, sportsEmojis, halloweenEmojis]
    let colors = [Color.yellow, Color.blue, Color.orange]
    @State var currendThemeIndex = 0
    @State var previousNumCards = 0
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeAdjuster
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 5)], spacing: 5) {
            let pairedEmojis = getEmojis()
            let color = colors[currendThemeIndex]
            ForEach(0..<pairedEmojis.count, id: \.self) { index in
                CardView(content: pairedEmojis[index], color: color)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    func getEmojis() -> [String] {
        let currentEmojis = emojis[currendThemeIndex]
        var numCardsToShow = Int.random(in: 2...currentEmojis.count)
        while numCardsToShow == previousNumCards {
            numCardsToShow = Int.random(in: 2...currentEmojis.count)
        }
        previousNumCards = numCardsToShow
        let emojisToShow = currentEmojis.shuffled()[0..<numCardsToShow]
        let pairedEmojisToShow = (emojisToShow + emojisToShow).shuffled()
        return pairedEmojisToShow
    }
    
    
    var themeAdjuster: some View {
        HStack {
            face
            Spacer()
            sports
            Spacer()
            halloween
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func themeAdjuster(index: Int, name: String, _ symbol: String) -> some View {
        Button(action: {
            currendThemeIndex = index
        }){
            VStack {
                Image(systemName: symbol)
                Text(name).font(.title)
            }
        }.padding(.horizontal)
    }
    
    var face: some View {
        return themeAdjuster(index: 0, name: "face", "face.smiling")
    }
    
    var sports: some View {
        return themeAdjuster(index: 1, name: "sports", "figure.run.circle")
    }
    
    var halloween: some View {
        return themeAdjuster(index: 2, name: "secret", "questionmark.circle")
    }
}

struct CardView: View {
    let content: String
    var color = Color.blue
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill(color).opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
