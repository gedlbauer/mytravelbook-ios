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
    
    init(name: String) {
        self.name = name
    }
}
