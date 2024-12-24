//
//  DeactivableDatePicker.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import SwiftUI

struct DeactivableDatePicker: View {
    @Environment(\.editMode) private var editMode
    let label: String
    @Binding var date: Date
    
    var body: some View {
        if editMode?.wrappedValue.isEditing ?? false {
            DatePicker(LocalizedStringKey(label),
                       selection: $date,
                       displayedComponents: [.date, .hourAndMinute])
        } else {
            LabeledContent(LocalizedStringKey(label)) {
                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(7)
            }
        }
    }
}
