//
//  JournalEntryDetailView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 17.12.24.
//

import SwiftUI

//var images: [Data]
//var creationDate: Date

struct JournalEntryDetailView: View {
    @Bindable var entry: JournalEntry
    var body: some View {
        VStack(alignment: .leading) {
            Form{
                LabeledContent{
                    TextField("Trip Title", text: $entry.title)
                }label: {Text("Title")}
                LabeledContent{
                    TextField("Location", text: Binding(
                        get: { entry.location ?? "" },
                        set: { entry.location = $0 }
                    ))
                } label: {Text("Location")}
                LabeledContent {
                    DatePicker("Entry Date",
                               selection: $entry.creationDate,
                               displayedComponents: [.date, .hourAndMinute])
                } label: {Text("Date")}
                Section(header:Text("Text")){
                    TextEditor(text: $entry.text)
                        .frame(minWidth: 200,
                               idealWidth: 250,
                               maxWidth: 400,
                               minHeight: 75,
                               idealHeight: 50,
                               maxHeight: .infinity)
                }
            }

            HStack {
                Text("Images").font(.title).padding()
                Text("Images").font(.title).padding()
                Text("Images").font(.title).padding()
                Text("Images").font(.title).padding()
                Text("Images").font(.title).padding()
            }.padding()
            ForEach(entry.images, id: \.self){ image in
                Text("image x")
            }
            Button(action: { }){
                Text("Add Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Journal Entry")
    }
}

#Preview {
    var trip = Trip(name: "San Francisco", entries: [])
    trip.entries.append(JournalEntry(title: "Test in SF", text: "Es war sehr schön hier! 10/10, ich würde wieder kommen! 🌴", images: [], location: "Hofkirchen", creationDate: Date.now, trip: trip))
    return JournalEntryDetailView(entry: trip.entries.first!)
}
