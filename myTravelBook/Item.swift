//
//  Item.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
