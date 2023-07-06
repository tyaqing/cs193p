
import SwiftUI

// 这个是ViewModel 用来处理用户反馈,并修改model
class EmojiMemoryGame: ObservableObject {
	static var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚲", "🛴", "🚔", "🚍", "🚘", "🚖"]
	
	static func createMemoryGame() -> MemorizeGame<String> {
		return MemorizeGame(numberOfPairsOfCards: 4) {
			index in EmojiMemoryGame.emojis[index]
		}
	}
	
	@Published private var model: MemorizeGame<String> = createMemoryGame()
	
	var cards: [MemorizeGame<String>.Card] {
		return model.cards
	}
	
	//	MARK: - Intents
	
	func choose(_ card: MemorizeGame<String>.Card) {
		model.choose(card)
	}
}
