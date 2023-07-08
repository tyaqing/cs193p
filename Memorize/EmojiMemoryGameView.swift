import CoreData
import SwiftUI

struct EmojiMemoryGameView: View {
	@ObservedObject var game: EmojiMemoryGame
	var body: some View {
		AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
			cardView(for: card)
		}
		.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)
		.padding(.horizontal)
	}

	// 初步理解就是外层直接带逻辑需要声明这是个ViewBuilder
	@ViewBuilder
	private func cardView(for card: EmojiMemoryGame.Card) -> some View {
		if card.isMatched, !card.isFaceUp {
			Rectangle().opacity(0)
		} else {
			CardView(card: card)
				.padding(4)
				.onTapGesture {
					game.choose(card)
				}
		}
	}
}

struct CardView: View {
	var card: EmojiMemoryGame.Card
//
//	init(_ card: EmojiMemoryGame.Card) {
//		self.card = card
//	}

	var body: some View {
		GeometryReader { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
				if card.isFaceUp {
					shape.fill().foregroundColor(.white)
					shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.circlePadding).opacity(0.5)
					Text(card.content).font(font(in: geometry.size))
				} else if card.isMatched {
					shape.opacity(0)
				} else {
					shape.fill()
				}
			}
		}
	}

	private func font(in size: CGSize) -> Font {
		Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
	}

	private enum DrawingConstants {
		static let cornerRadius: CGFloat = 10
		static let lineWidth: CGFloat = 3
		static let fontScale: CGFloat = 0.7
		static let circlePadding: CGFloat = 5
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		game.choose(game.cards.first!)
		return EmojiMemoryGameView(game: game)
			.preferredColorScheme(.light)
			.previewDevice("iPhone 14")
	}
}
