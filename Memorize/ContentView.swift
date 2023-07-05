//
//  ContentView.swift
//  Memorize
//
//  Created by yakir on 2023/7/4.
//

import CoreData
import SwiftUI

struct ContentView: View {
	var body: some View {
		HStack {
			ForEach(0 ..< 4) { index in
				CardView(isFaceUp: index % 2 == 0)
			}
		}
		.padding(.horizontal)
		.foregroundColor(/*@START_MENU_TOKEN@*/ .red/*@END_MENU_TOKEN@*/)
	}
}

struct CardView: View {
	var isFaceUp: Bool

	var body: some View {
		ZStack(alignment: .center) {
			if isFaceUp {
				RoundedRectangle(cornerRadius: 20)
					.fill()
					.foregroundColor(.white)
				RoundedRectangle(cornerRadius: 20)
					.stroke(lineWidth: 3)
				Text("👻")
					.font(.largeTitle)
			} else {
				RoundedRectangle(cornerRadius: 20)
					.fill()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
			.previewDevice("iPhone 14")
		ContentView()
			.preferredColorScheme(.light)
			.previewDevice("iPhone 14")
	}
}
