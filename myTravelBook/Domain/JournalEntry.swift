//
//  JournalEntry.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import Foundation
import SwiftData

@Model
final class JournalEntry {
    var title: String
    var text: String
    @Attribute(.externalStorage)
    var images: [Data]
    var location: String?
    var creationDate: Date
    @Relationship
    var trip: Trip?
    
    init(title: String, text: String, images: [Data], location: String? = nil, creationDate: Date, trip: Trip? = nil) {
        self.title = title
        self.text = text
        self.images = images
        self.location = location
        self.creationDate = creationDate
        self.trip = trip
    }
    
    func clone() -> Self {
        return Self(title: title, text: text, images: images, location: location, creationDate: creationDate, trip: nil)
    }
}
