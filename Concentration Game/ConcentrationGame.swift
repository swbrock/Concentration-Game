//
//  ConcentrationGame.swift
//  Concentration Game
//
//  Created by Stephen Brockbank  on 10/18/23.
//

import Foundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    var x: Int {
        return y * 5
    }
    
    var score: Int {
        cards.reduce(0) { $0 + $1.score}
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    // MARK as Matched
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].viewCount += 1
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        
        
        fileprivate(set) var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        fileprivate(set) var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        fileprivate(set) var content: CardContent
        fileprivate(set) var id = UUID()
        fileprivate(set) var viewCount = 0
        
        fileprivate(set) var bonusTimeLimit: TimeInterval = 5
        //fileprivate(set) var bonusTimeLimit: TimeInterval = Score.maxBonusTime

        fileprivate(set) var lastFaceUpTime: Date?
        fileprivate(set) var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        var score: Int {
            if isMatched {
                return 5 - viewCount + bonusScore
                //return Score.baseMatchValue - viewCount + bonusScore

            }
            if viewCount > 0 {
                return -viewCount + 1
            }
            
            return 0
        }
        
        var bonusRemainingPercent: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0)
            ? bonusTimeRemaining / bonusTimeLimit
            : 0
        }
        
        private var bonusScore: Int {
            Int(bonusRemainingPercent * 1)
            //Int(bonusRemainingPercent * Score.bonusFactor)

        }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpTime {
                pastFaceUpTime + Date().timeIntervalSince(lastFaceUpTime)
            } else {
                pastFaceUpTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime && lastFaceUpTime == nil {
                lastFaceUpTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpTime = nil
        }
    }
}
