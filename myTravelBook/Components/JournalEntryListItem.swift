//
//  JournalEntryListItem.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 17.12.24.
//

import SwiftUI
import SwiftData

struct JournalEntryListItem: View {
    @Bindable var entry: JournalEntry
    var body: some View {
        NavigationLink {
            JournalEntryDetailView(entry: entry)
        } label: {
            VStack (alignment: .leading){
                Text(entry.title).font(.title)
                if let location = entry.location {
                    Text(location)
                }
                if(!entry.images.isEmpty){
                    ForEach(entry.images, id: \.hashValue){ imageData in
                        if let image = Image(data: imageData) {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 300, maxHeight: 300)
                        } else {
                            Text("Image not available")
                        }
                    }
                }
                Text(entry.creationDate.formatted(date: .abbreviated, time: .shortened))
                Text(entry.text)
            }
        }
    }
}

#Preview {
    var trip = Trip(name: "San Francisco", entries: [])
    trip.entries.append(JournalEntry(title: "Test in SF", text: "Es war sehr schön hier! 10/10, ich würde wieder kommen! 🌴", images: [], location: "Hofkirchen", creationDate: Date.now, trip: trip))
    return JournalEntryListItem(entry: trip.entries.first!)
}
