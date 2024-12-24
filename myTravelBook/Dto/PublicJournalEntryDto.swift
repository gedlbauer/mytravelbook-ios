//
//  PublicEntryDto.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import Foundation

struct PublicJournalEntryDto: Codable, Identifiable {
    var id: UUID
    var title: String
    var text: String
    var images: [ImageDto]
    var locationName: String?
    var dateTime: Date
}
