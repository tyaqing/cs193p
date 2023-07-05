//
//  MemorizeApp.swift
//  Memorize
//
//  Created by yakir on 2023/7/4.
//

import SwiftUI

@main
struct MemorizeApp: App {
	let persistenceController = PersistenceController.shared

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
		}
	}
}
