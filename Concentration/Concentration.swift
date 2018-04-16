//
//  Concentration.swift
//  Concentration
//
//  Created by Zachary Minner on 4/10/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    var flipCount = 0
    var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private func randomize(listOf cards: [Card]) -> [Card] {
        var arr = cards
        for i in 1..<cards.count {
            let randomIndex = i.arc4random
            let temp = arr[i]
            arr[i] = arr[randomIndex];
            arr[randomIndex] = temp;
        }
        return arr
    }
    
    private func startGame(with numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "init(with: \(numberOfPairsOfCards): must be have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // adds two copies of card class to cards array
            cards += [card, card]
        }
        cards = self.randomize(listOf: cards)
    }
    
    private func resetGame() {
        flipCount = 0
        score = 0
        cards = [Card]()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                
                if cards[index].hasFlippedAtLeastOnce == true {
                    score -= 1
                }
            }
        }
        cards[index].hasFlippedAtLeastOnce = true
        flipCount += 1
    }

    func startNewGame(with numberOfPairsOfCards: Int) {
        // reset game
        self.resetGame()
        // init new game
        self.startGame(with: numberOfPairsOfCards)
    }
    
    init(with numberOfPairsOfCards: Int) {
        self.startGame(with: numberOfPairsOfCards)
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
