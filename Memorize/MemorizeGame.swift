import Foundation

// 这个是Model 按照Model的说法,主要是定义原始数据
struct MemorizeGame<CardContent> where CardContent: Equatable {
	private(set) var cards: [Card]

	private var faceUpCardIndex: Int?

	// mutating 表示这个函数可以访问并修改数据
	mutating func choose(_ card: Card) {
		if let
			chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
			!cards[chosenIndex].isFaceUp,
			!cards[chosenIndex].isMatched
		{
			if let potentialMatchIndex = faceUpCardIndex {
				if cards[potentialMatchIndex].content == cards[chosenIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
				}
				faceUpCardIndex = nil
			} else {
				for index in cards.indices {
					cards[index].isFaceUp = false
				}
				faceUpCardIndex = chosenIndex
			}
			// 这里必须修改原来的实例,如果赋值,会有值的复制
			cards[chosenIndex].isFaceUp.toggle()
		}
		print("card not found")
	}

	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = []
		for pairIndex in 0 ..< numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			for index in 0 ..< 2 {
				cards.append(Card(content: content, id: pairIndex * 2 + index))
			}
		}
	}

	// Identifiable 协议可以让遍历无需指定id
	struct Card: Identifiable {
		var isFaceUp = false
		var isMatched = false
		let content: CardContent
		let id: Int
	}
}
