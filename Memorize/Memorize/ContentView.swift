//
//  ContentView.swift
//  Memorize
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

 */

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("😁").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12) 
            }
           
        }
    }
}

#Preview {
    ContentView()
}
