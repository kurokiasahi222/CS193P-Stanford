//
//  FlyingNumber.swift
//  Memorize
//
//  Created by 黒木朝陽 on 7/11/25.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
