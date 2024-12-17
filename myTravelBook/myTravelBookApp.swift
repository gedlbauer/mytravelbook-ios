//
//  myTravelBookApp.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import SwiftUI
import SwiftData

@main
struct myTravelBookApp: App {
    @AppStorage("welcomeScreenWasShown")
    var welcomeScreenWasShown: Bool = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Trip.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if $welcomeScreenWasShown.wrappedValue {
                ContentView()
            } else {
                WelcomeView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
