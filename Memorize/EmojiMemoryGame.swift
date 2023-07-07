
import SwiftUI

// 这个是ViewModel 用来处理用户反馈,并修改model
class EmojiMemoryGame: ObservableObject {
	typealias Card = MemorizeGame<String>.Card
	private static var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚲", "🛴", "🚔", "🚍", "🚘", "🚖"]
	
	private static func createMemoryGame() -> MemorizeGame<String> {
		return MemorizeGame(numberOfPairsOfCards: 4) {
			index in EmojiMemoryGame.emojis[index]
		}
	}
	 
	@Published private var model = createMemoryGame()
	
	/*
	 充当model的gatekeeper
	 swift可以检测struct的变化,
	 */
	var cards: [Card] {
		return model.cards
	}
	
	//	MARK: - Intents
	
	func choose(_ card: Card) {
		model.choose(card)
	}
}

struct Previews_EmojiMemoryGame_Previews: PreviewProvider {
	static var previews: some View {
		/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
	}
}
