//
//  TripDetailView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 15.12.24.
//

import SwiftUI
import _SwiftData_SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip

    var body: some View {
            List {
                ForEach(trip.entries) { entry in
                    JournalEntryListItem(entry: entry)
                }
                .onDelete(perform: deleteEntry)
            }.overlay {
                if trip.entries.isEmpty {
                    NavigationLink("Add your first Journal Entry"){
                        JournalEntryDetailView(trip: trip)
                    }
                }
            }
            .animation(.easeInOut, value: trip.entries.isEmpty)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink {
                        JournalEntryDetailView(trip: trip)
                    } label: {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }.navigationTitle(trip.name)
    }

    private func deleteEntry(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                trip.entries.remove(at: index)
            }
        }
    }
}

#Preview {
    var trip = Trip(name: "San Francisco", entries: [])
    trip.entries.append(JournalEntry(title: "Test in SF", text: "Es war sehr schön hier! 10/10, ich würde wieder kommen! 🌴", images: [], location: "Hofkirchen", creationDate: Date.now, trip: trip))
    return NavigationSplitView{TripDetailView(trip: trip)}
    detail: {Text("Test")}
}
