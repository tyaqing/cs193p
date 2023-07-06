import CoreData
import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel: EmojiMemoryGame

	var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
				ForEach(viewModel.cards) { card in
					CardView(card: card)
						.aspectRatio(2 / 3, contentMode: .fit)
						.onTapGesture {
							viewModel.choose(card)
						}
				}
			}
		}
		.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)
		.padding(.horizontal)
	}
}

struct CardView: View {
	var card: MemorizeGame<String>.Card
	var body: some View {
		ZStack(alignment: .center) {
			let shape = RoundedRectangle(cornerRadius: 20)
			if card.isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(card.content).font(.largeTitle)
			} else {
				shape.fill()
				Text(" ").font(.largeTitle)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		ContentView(viewModel: game)
			.preferredColorScheme(.light)
			.previewDevice("iPhone 14")
	}
}
