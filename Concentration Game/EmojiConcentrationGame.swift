//
//  EmojiConcentrationGame.swift
//  Concentration Game
//
//  Created by Stephen Brockbank  on 10/18/23.
//

import SwiftUI

@Observable class EmojiConcentrationGame{
    
    
    //Mark - Properties
    
    static let emojis = ["👨🏻‍🍼", "🎱", "🏹", "🌶️", "📎", "🍒"]
    
    private var game = createGame()
    private var isVisible = false
    
    
    static func createGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 3...emojis.count)) {emojis[$0]}
    }
    
    var dealtCards: Array<ConcentrationGame<String>.Card> {
        isVisible ? game.cards : []
    }
    
    func dealCards() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isVisible = true
        }
    }

    
    // Mark - Model Access
    
    var score: Int {
        game.score
    }
    
    
    //Mark - User Intents
    func choose(_ card: ConcentrationGame<String>.Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game.choose(card: card)
        }
    }
    
    func newGame() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isVisible = false
            game = EmojiConcentrationGame.createGame()
        }
        
        dealCards()
    }
}

//MARK- --Constants

private struct Constants {
    static let animationDuration = 0.5
}
