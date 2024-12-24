//
//  ImageDto.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import Foundation

struct ImageDto: Codable, Identifiable {
    var id: UUID
    var url: String
}
