//
//  StartGameView.swift
//  demo-app
//
//  Created by 黒木朝陽 on 3/7/25.
//


import SwiftUI

struct StartGameView: View {
    @State private var selectedTheme: String = "Numbers"
    @State private var selectedPlayers: Int = 1
    @State private var selectedGridSize: String = "4x4"
    @State private var navigateToGame = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.08, green: 0.16, blue: 0.22)
                    .ignoresSafeArea()

                VStack(alignment: .center, spacing: 45) {
                    Text("memory")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99))
                    RectangleView
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
                .padding(.bottom, 116)
                .frame(maxWidth: .infinity, maxHeight: .infinity
                       ,alignment: .topLeading)
            }
        }
    }

    var RectangleView: some View { // Rename this to avoid collision with SwiftUI's Rectangle type
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(Color(red: 0.99, green: 0.99, blue: 0.99))
                .cornerRadius(10)
            
            VStack(spacing: 40) {  // container
                VStack (alignment: .leading, spacing: 11) {
                    Text("Select Theme")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.44, green: 0.57, blue: 0.65))
                    HStack {
                        ThemeButton(label: "Numbers", isSelected: selectedTheme == "Numbers") {
                            selectedTheme = "Numbers"
                        }
                        ThemeButton(label: "Icons", isSelected: selectedTheme == "Icons") {
                            selectedTheme = "Icons"
                        }
                    }
                }
                VStack (alignment: .leading, spacing: 11) {
                    Text("Grid Size")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.44, green: 0.57, blue: 0.65))
                    HStack {
                        ThemeButton(label: "4x4", isSelected: selectedGridSize == "4x4") {
                            selectedGridSize = "4x4"
                        }
                        ThemeButton(label: "6x6", isSelected: selectedGridSize == "6x6") {
                            selectedGridSize = "6x6"
                        }
                    }
                }
                VStack(alignment: .center) {
                    StartButton(label: "Start Game") {
                        navigateToGame = true
                    }
                }
            }  // end of vstack container
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 24)
            .padding(.vertical, 69)
        } // end of zstack
        .frame(height: 386)
    }
}


struct ThemeButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99))
                .frame(width: 134)
                .padding(.vertical, 10)
                
        }
        .background(isSelected ? Color(red: 0.19, green: 0.28, blue: 0.35) : Color(red: 0.74, green: 0.81, blue: 0.85))
        .cornerRadius(26)
    }
}

struct StartButton: View {
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 18, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99))
                .frame(width: 279)
                .padding(.vertical, 10)
            
        }
        .background(Color(red: 0.99, green: 0.64, blue: 0.08))
        .cornerRadius(26)
    }
}












struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView()
    }
}
