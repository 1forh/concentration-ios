//
//  Card.swift
//  Concentration
//
//  Created by Zachary Minner on 4/10/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var hasFlippedAtLeastOnce = false
    var identifier: Int
    var emoji: String
    
    private static let emojis = Emojis()
    private static var emojiChoices = emojis.randomTheme
    private static var emojiDict = [Int:String]()
    private static var identifierFactory = 0
    
    // `static`: attached to type not Card
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    private static func getEmoji(for identifier: Int) -> String {
        if Card.emojiDict[identifier] == nil, Card.emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(Card.emojiChoices.count)))
            let randomStringIndex = Card.emojiChoices.index(Card.emojiChoices.startIndex, offsetBy: randomIndex)
            Card.emojiDict[identifier] = String(Card.emojiChoices.remove(at: randomStringIndex)) // returns what it removes
        }
        return Card.emojiDict[identifier] ?? "?"
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        self.emoji = Card.getEmoji(for: self.identifier)
    }
}

