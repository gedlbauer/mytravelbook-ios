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
                ScrollView(.horizontal) {
                    HStack(spacing: 0){
                        ForEach(entry.images, id: \.self) { imageData in
                            if let image = Image(data: imageData) {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 150)
                            } else {
                                Text("Image not available")
                            }
                        }
                    }
                }
                Text(entry.creationDate.formatted(date: .abbreviated, time: .shortened))
                Text(entry.text)
            }
        }
    }
}
