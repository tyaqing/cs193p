import Foundation

// 这个是Model 按照Model的说法,主要是定义原始数据
struct MemorizeGame<CardContent> where CardContent: Equatable {
	private(set) var cards: [Card]

	private var faceUpCardIndex: Int? {
		get { cards.indices.filter { cards[$0].isFaceUp }.onAndOnly }
		set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
	}

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
				cards[chosenIndex].isFaceUp = true
			} else {
				faceUpCardIndex = chosenIndex
			}
		}
		print("card not found")
	}

	mutating func shuffle() {
		cards.shuffle()
	}

	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = []
		for pairIndex in 0 ..< numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			for index in 0 ..< 2 {
				cards.append(Card(content: content, id: pairIndex * 2 + index))
			}
		}
		cards.shuffle()
	}

	// Identifiable 协议可以让遍历无需指定id
	struct Card: Identifiable, Equatable {
		var isFaceUp = false {
			didSet {
				if isFaceUp {
					startUsingBonusTime()
				} else {
					stopUsingBonusTime()
				}
			}
		}

		var isMatched = false {
			didSet {
				stopUsingBonusTime()
			}
		}

		let content: CardContent
		let id: Int

		// MARK: - Bouns Time

		// this could give matching bonus points
		// if the user matches the card
		// before a certain amount of time passes during which the card is face up

		// can be zero which means "no bonus available" for this card
		var bonusTimeLimit: TimeInterval = 6

		// how long this card has ever been face up
		private var faceUpTime: TimeInterval {
			if let lastFaceUpDate = lastFaceUpDate {
				return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
			} else {
				return pastFaceUpTime
			}
		}

		// the last time this card was turned face up (and is still face up)
		var lastFaceUpDate: Date?
		// the accumulated time this card has been face up in the past
		// (i.e. not including the current time it's been face up if it is currently so)
		var pastFaceUpTime: TimeInterval = 0

		// how much time left before the bonus opportunity runs out
		var bonusTimeRemaining: TimeInterval {
			max(0, bonusTimeLimit - faceUpTime)
		}

		// percentage of the bonus time remaining
		var bonusRemaining: Double {
			(bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
		}

		// whether the card was matched during the bonus time period
		var hasEarnedBonus: Bool {
			isMatched && bonusTimeRemaining > 0
		}

		// whether we are currently face up, unmatched and have not yet used up the bonus window
		var isConsumingBonusTime: Bool {
			isFaceUp && !isMatched && bonusTimeRemaining > 0
		}

		// called when the card transitions to face up state
		private mutating func startUsingBonusTime() {
			if isConsumingBonusTime, lastFaceUpDate == nil {
				lastFaceUpDate = Date()
			}
		}

		// called when the card goes back face down (or gets matched)
		private mutating func stopUsingBonusTime() {
			pastFaceUpTime = faceUpTime
			lastFaceUpDate = nil
		}
	}
}

// 拓展Array
extension Array {
	var onAndOnly: Element? {
		if count == 1 {
			return first
		} else {
			return nil
		}
	}
}
