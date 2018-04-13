//
//  ViewController.swift
//  Concentration
//
//  Created by Zachary Minner on 4/9/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // `lazy` - doesn't initialize until it is used
    lazy var numberOfPairsOfCards = (cardButtons.count  + 1) / 2
    lazy var game = Concentration(with: numberOfPairsOfCards)
    
    // known as instance variable or property
    var flipCount = 0 {
        // property observer:  executed every time this property is updated
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // array of UIButton
    @IBOutlet var cardButtons: [UIButton]!

    // method
    // `@IBAction` is a directive that puts that circle on line 15
    // shows which button calls this method
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        // cardButtons.index(of: sender) returns an optional Int
        // `!` assume optional is set
        // if optional is in set state, execute block
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // FIXME: when startNewGame is fired
    // some of the squares have no emoji
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startNewGame(with: numberOfPairsOfCards)
        flipCount = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor =  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3782833146, green: 0.519879679, blue: 1, alpha: 0) : #colorLiteral(red: 0.3782833146, green: 0.519879679, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🔥", "🤖", "🧀", "👽", "👾", "👌", "😈", "💩"]
    var emoji = [Int:String]() // dictionary
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) // returns what it removes
        }
        
        // write like this instead
        return emoji[card.identifier] ?? "?"
    }
}

