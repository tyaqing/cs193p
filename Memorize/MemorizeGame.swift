import Foundation

struct MemorizeGame<CardContent> {
	var card: [Card]

	func choose(_ card: Card) {}

	struct Card {
		var isFaceUp: Bool
		var isMatched: Bool
		var content: CardContent
	}
}
