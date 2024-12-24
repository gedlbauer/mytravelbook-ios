//
//  DeactivalbeTextEditor.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import SwiftUI

struct DeactivableTextEditor: View {
    @Environment(\.editMode) private var editMode
    let label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(label))
            if editMode?.wrappedValue.isEditing ?? false {
                TextEditor(text: $text)
                    .frame(minHeight: 75,
                           idealHeight: 75,
                           maxHeight: .infinity)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                    )
            } else {
                ScrollView(.vertical) {
                    Text(text)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                    .frame(minHeight: 75,
                           idealHeight: 75)
                    .padding(EdgeInsets(top: 13, leading: 10, bottom: 0, trailing: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                    )
            }
            
        }
    }
}
