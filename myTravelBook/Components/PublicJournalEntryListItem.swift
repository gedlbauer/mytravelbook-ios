//
//  PublicJournalEntryListItem.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import SwiftUI
import NukeUI

struct PublicJournalEntryListItem: View {
    @State var entry: PublicJournalEntryDto
    var body: some View {
        LazyVStack (alignment: .leading){
            Text(entry.title).font(.title)
            if let location = entry.locationName {
                Text(location)
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0){
                    ForEach(entry.images) { image in
                        LazyImage(url: URL(string: image.url)){ state in
                            if let image = state.image {
                                image
                                    .resizable()
                                    .frame(maxHeight: .infinity) // Fill parent's height
                                    .scaledToFit()
                            } else {
                                ProgressView().frame(idealHeight: 150, maxHeight: .infinity)
                            }
                        }
                    }
                }.frame(maxHeight: 150)
            }
            Text(entry.dateTime.formatted(date: .abbreviated, time: .shortened))
            Text(entry.text)
        }
    }
}

