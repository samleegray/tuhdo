//
//  TuhDoApp.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI
import SwiftData

@main
struct TuhDoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, migrationPlan: ItemMigrationPlan.self, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NoteList()
        }
        .modelContainer(sharedModelContainer)
    }
}
