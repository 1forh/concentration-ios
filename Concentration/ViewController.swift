//
//  ViewController.swift
//  Concentration
//
//  Created by Zachary Minner on 4/9/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(with: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count  + 1) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // FIXME: when startNewGame is fired
    // some of the squares have no emoji
    @IBAction private func startNewGame(_ sender: UIButton) {
//        game.startNewGame(with: numberOfPairsOfCards)
        game = Concentration(with: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateCardState()
        updateLabelText()
    }
    
    private func updateCardState() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(card.emoji, for: UIControlState.normal)
                button.backgroundColor =  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3782833146, green: 0.519879679, blue: 1, alpha: 0) : #colorLiteral(red: 0.3782833146, green: 0.519879679, blue: 1, alpha: 1)
            }
        }
    }
    
    private func updateLabelText() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
}
