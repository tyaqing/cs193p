//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by yakir on 2023/7/6.
//

import SwiftUI

class EmojiMemoryGame {
	static var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚲", "🛴", "🚔", "🚍", "🚘", "🚖"]

	static func createMemoryGame() -> MemorizeGame<String> {
		return MemorizeGame(numberOfPairsOfCards: 4) {
			index in EmojiMemoryGame.emojis[index]
		}
	}

	var model: MemorizeGame<String> = createMemoryGame()

	var cards: [MemorizeGame<String>.Card] {
		return model.cards
	}
}
