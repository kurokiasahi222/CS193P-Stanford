//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 黒木朝陽 on 7/10/25.
//


import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    @ViewBuilder var content: (Item) -> ItemView
    // content =  card in CardView(card). A function that takes in card and return a view
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = calculateGridItemSize (
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)]
                      , spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
}

func calculateGridItemSize(
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        print(size.width)
        print(size)
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
}

