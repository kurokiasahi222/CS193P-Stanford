//
//  ContentView.swift
//  Memorize
//
//  Created by 黒木朝陽 on 6/29/25.
//

import SwiftUI

/*
 "View" means behaves like a View (Protoc  ol): requires "body" computed property
 When defining a custom view, it requires a "body"; however, things like
 VStack, Image, Text are builtin Views, thus dont require a body
 "some" is a opaque type -> body type conforms to View, but the exact type
 depends on the body's content
 ex) Text is a struct that conforms to View
 Views are immutable
 */

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "🦇", "🍬", "🧙‍♀️", "🕸️", "🧛‍♂️", "🕯️", "🍭"]
    
    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
