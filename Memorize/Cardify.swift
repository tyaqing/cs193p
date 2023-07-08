import SwiftUI

// ViewModifier 的写法有点类似于vue中的slot 将内容包裹在Card里面
struct Cardify: ViewModifier {
	var isFaceUp: Bool
	func body(content: Content) -> some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
			if self.isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
			} else {
				shape.fill()
			}
			content
				.opacity(self.isFaceUp ? 1 : 0)
		}
	}

	private enum DrawingConstants {
		static let cornerRadius: CGFloat = 10
		static let lineWidth: CGFloat = 3
	}
}

extension View {
	func cardify(isFaceUp: Bool) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp))
	}
}
