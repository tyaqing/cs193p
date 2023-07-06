import Foundation

struct MemorizeGame<CardContent> {
	private(set) var cards: [Card]

	func choose(_ card: Card) {}

	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = [Card]()
		for pairIndex in 0 ..< numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			cards.append(Card(content: content))
		}
	}

	struct Card {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
	}
}
