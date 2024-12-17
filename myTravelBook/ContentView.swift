//
//  ContentView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            Tab("My Trips", systemImage: "globe.europe.africa.fill") {
                MyTripsOverView()
            }


            Tab("Friends", systemImage: "person.3.fill") {
                PublicJournalEntriesOverView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}
