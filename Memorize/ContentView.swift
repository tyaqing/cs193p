//
//  ContentView.swift
//  Memorize
//
//  Created by yakir on 2023/7/4.
//

import CoreData
import SwiftUI

struct ContentView: View {
	var emojis = ["📷", "🍌", "🍇", "👻"]
	var body: some View {
		HStack {
			ForEach(emojis, id: \.self) { emoji in
				CardView(content: emoji, isFaceUp: false)
			}
		}
		.padding(.horizontal)
		.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)
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
				shape.stroke(lineWidth: 3)
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
