//
//  PostPublicJournalEntryDto.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import Foundation

struct PostPublicJournalEntryDto: Codable {
    var title: String
    var text: String
    var locationName: String?
    var images: [String]
    var dateTime: Date
    
    init(from: JournalEntry) {
        title = from.title
        text = from.text
        locationName = from.location
        dateTime = from.creationDate
        images = from.images.map{$0.base64EncodedString()}
    }
    
}
