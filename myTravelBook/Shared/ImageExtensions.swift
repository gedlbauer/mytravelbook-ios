//
//  ImageExtensions.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 17.12.24.
//

import SwiftUI

extension Image {
    init?(data: Data) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
