//
//  ContentView.swift
//  Memorize
//
//  Created by yakir on 2023/7/4.
//

import CoreData
import SwiftUI

struct ContentView: View {
	var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚲", "🛴", "🚔", "🚍", "🚘", "🚖"]
	@State var emojiCount = 8
	var body: some View {
		VStack {
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
					ForEach(emojis[0 ..< emojiCount], id: \.self) { emoji in
						CardView(content: emoji, isFaceUp: true)
							.aspectRatio(2 / 3, contentMode: .fit)
					}
				}
			}
			.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)

			Spacer()
			HStack {
				add
				Spacer()
				remove
			}
			.font(.largeTitle)
		}
		.padding(.horizontal)
	}

	var add: some View {
		Button {
			if emojiCount < emojis.count {
				emojiCount += 1
			}
		} label: {
			Image(systemName: "plus.circle")
		}
	}

	var remove: some View {
		Button {
			if emojiCount > 1 {
				emojiCount -= 1
			}
		} label: {
			Image(systemName: "minus.circle")
		}
	}
}

struct CardView: View {
	var content: String
	@State var isFaceUp: Bool

	var body: some View {
		ZStack(alignment: .center) {
			let shape = RoundedRectangle(cornerRadius: 20)
			if isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 3)
				Text(content).font(.largeTitle)
			} else {
				shape.fill()
			}
		}.onTapGesture {
			isFaceUp.toggle()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.light)
			.previewDevice("iPhone 14")
	}
}
