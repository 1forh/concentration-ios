//
//  Concentration.swift
//  Concentration
//
//  Created by Zachary Minner on 4/10/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func randomize(listOf cards: [Card]) -> [Card] {
        var arr = cards
        for i in 1..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(i)))
            let temp = arr[i]
            arr[i] = arr[randomIndex];
            arr[randomIndex] = temp;
        }
        return arr
    }
    
    func startNewGame(with numberOfPairsOfCards: Int) {
        // reset game
        self.resetGame()
        // init new game
        self.startGame(with: numberOfPairsOfCards)
    }
    
    func resetGame() {
        cards = [Card]()
    }
    
    func startGame(with numberOfPairsOfCards: Int) {
        // `_` means don't really care what the variable is named cause it's never used in the block
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // adds two copies of card class to cards array
            cards += [card, card]
        }
        cards = self.randomize(listOf: cards)
    }
    
    init(with numberOfPairsOfCards: Int) {
        self.startGame(with: numberOfPairsOfCards)
    }
}
