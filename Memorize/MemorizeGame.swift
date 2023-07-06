import Foundation

// 这个是Model 按照Model的说法,主要是定义原始数据
struct MemorizeGame<CardContent> {
	private(set) var cards: [Card]

	mutating func choose(_ card: Card) {
		let chosenIndex = index(of: card)
		cards[chosenIndex].isFaceUp.toggle()

		print("chosenCard= \(chosenIndex)")
	}

	func index(of card: Card) -> Int {
		for index in 0 ..< cards.count {
			if cards[index].id == card.id {
				return index
			}
		}
		return 0
	}

	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = [Card]()
		for pairIndex in 0 ..< numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			for index in 0 ..< 2 {
				cards.append(Card(content: content, id: pairIndex * 2 + index))
			}
		}
	}

	// Identifiable 协议可以让遍历无需指定id
	struct Card: Identifiable {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
		var id: Int
	}
}
