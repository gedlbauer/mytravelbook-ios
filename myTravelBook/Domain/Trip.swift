//
//  Trip.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import Foundation
import SwiftData

@Model
final class Trip {
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \JournalEntry.trip)
    var entries: [JournalEntry]
    
    init(name: String, entries: [JournalEntry] = []) {
        self.name = name
        self.entries = entries
    }
}
