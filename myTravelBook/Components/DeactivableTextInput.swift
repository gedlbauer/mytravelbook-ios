//
//  DeactivableTextInput.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import SwiftUI

struct DeactivableTextInput: View {
    @Environment(\.editMode) private var editMode
    let label: String
    let placeholder: String
    @Binding private var text: String?
    
    init(label: String, placeholder: String, text: Binding<String?>) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
    }
    
    init(label: String, placeholder: String, text: Binding<String>) {
        self.label = label
        self.placeholder = placeholder
        self._text = Binding(get: {Optional(text.wrappedValue)}, set: {text.wrappedValue = $0 ?? ""})
    }
    
    var body: some View {
        LabeledContent(LocalizedStringKey(label)) {
            if editMode?.wrappedValue.isEditing ?? false {
                TextField(LocalizedStringKey(placeholder), text: $text.bound)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text(text.bound)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(7)
            }
        }
    }
}
