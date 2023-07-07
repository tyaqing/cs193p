import CoreData
import SwiftUI

struct EmojiMemoryGameView: View {
	@ObservedObject var game: EmojiMemoryGame
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
				ForEach(game.cards) { card in
					CardView(card)
						.aspectRatio(2 / 3, contentMode: .fit)
						.onTapGesture {
							game.choose(card)
						}
				}
			}
		}
		.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)
		.padding(.horizontal)
	}
}

struct CardView: View {
	private var card: EmojiMemoryGame.Card

	init(_ card: EmojiMemoryGame.Card) {
		self.card = card
	}

	var body: some View {
		GeometryReader { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
				if card.isFaceUp {
					shape.fill().foregroundColor(.white)
					shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					Text(card.content)
						.font(font(in: geometry.size))
				} else if card.isMatched {
					shape.opacity(0)
				} else {
					shape.fill()
					//				Text(" ").font(.largeTitle)
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
		static let fontScale: CGFloat = 0.75
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		EmojiMemoryGameView(game: game)
			.preferredColorScheme(.light)
			.previewDevice("iPhone 14")
	}
}
