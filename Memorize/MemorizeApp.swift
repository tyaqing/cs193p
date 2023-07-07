//
//  MemorizeApp.swift
//  Memorize
//
//  Created by yakir on 2023/7/4.
//

import SwiftUI

@main
struct MemorizeApp: App {
//	let persistenceController = PersistenceController.shared
	private let game = EmojiMemoryGame()
	var body: some Scene {
		WindowGroup {
			EmojiMemoryGameView(game: game)
//				.environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
	}
}
