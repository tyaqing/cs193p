import SwiftUI

// ViewModifier 的写法有点类似于vue中的slot 将内容包裹在Card里面
struct Cardify: AnimatableModifier {
	init(isFaceUp: Bool) {
		rotation = isFaceUp ? 0 : 180
	}

	var animatableData: Double {
		get { rotation }
		set { rotation = newValue }
	}

	var rotation: Double
	func body(content: Content) -> some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
			if rotation < 90 {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
			} else {
				shape.fill()
			}
			content
				.opacity(rotation < 90 ? 1 : 0)
		}
		.rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
	}

	private enum DrawingConstants {
		static let cornerRadius: CGFloat = 10
		static let lineWidth: CGFloat = 3
	}
}

extension View {
	func cardify(isFaceUp: Bool) -> some View {
		modifier(Cardify(isFaceUp: isFaceUp))
	}
}
