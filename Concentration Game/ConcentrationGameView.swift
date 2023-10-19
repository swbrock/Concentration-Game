//
//  ContentView.swift
//  Concentration Game
//
//  Created by Stephen Brockbank  on 10/18/23.
//

import SwiftUI

struct ConcentrationGameView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                CardView(isFaceUp: index > 1)
            }
        }        
        .padding()

    }
}

struct CardView: View {
    var isFaceUp: Bool
    
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                Text("👨🏻‍🍼")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
        .foregroundStyle(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ConcentrationGameView()
}
