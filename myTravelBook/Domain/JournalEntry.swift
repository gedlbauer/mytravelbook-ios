//
//  JournalEntry.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import Foundation

final class JournalEntry {
    var title: String
    var text: String
    var images: [Data]
    var location: String?
    var creationDate: Date
    
    init(title: String, text: String, images: [Data], location: String? = nil, creationDate: Date) {
        self.title = title
        self.text = text
        self.images = images
        self.location = location
        self.creationDate = creationDate
    }
}
