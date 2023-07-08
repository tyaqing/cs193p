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

	var body: some View {
		GeometryReader { geometry in
			ZStack {
				Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.circlePadding).opacity(0.5)
				Text(card.content)
					.rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
					.animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
					.font(Font.system(size: DrawingConstants.fontSize))
					.scaleEffect(scale(thatFits: geometry.size))
			}
			.cardify(isFaceUp: card.isFaceUp)
		}
	}

	private func scale(thatFits size: CGSize) -> CGFloat {
		min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
	}

	private enum DrawingConstants {
		static let fontScale: CGFloat = 0.7
		static let circlePadding: CGFloat = 5
		static let fontSize: CGFloat = 32
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
