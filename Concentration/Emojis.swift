//
//  Emojis.swift
//  Concentration
//
//  Created by Zachary Minner on 4/12/18.
//  Copyright © 2018 1forh. All rights reserved.
//

import Foundation

struct Emojis {

    var randomTheme = String()
    
    static let themes = [
        "😀😝😂😬🤠😎🙂🤓😇",
        "🦓🐥🦖🐋🐸🐑🦉🦊🐒",
        "🏀⚽️🏈🎾⚾️🥅⛳️🏸🏐",
        "👻🔥🤖🧀👽👾👌😈�"
    ]
    
    static func getRandomTheme() -> String {
        return Emojis.themes[Emojis.themes.count.arc4random]
    }
    
    init() {
        self.randomTheme = Emojis.getRandomTheme()
    }
}
