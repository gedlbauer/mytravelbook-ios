//
//  JournalEntryDetailView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 17.12.24.
//

import SwiftUI
import PhotosUI

struct JournalEntryDetailView: View {
    private let journalEntryApi = PublicJournalEntryApi()
    private var entry: JournalEntry?
    @State private var selectedItems: [PhotosPickerItem] = []
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) var dismiss
    
    @State private var entryTitle: String
    @State private var entryText: String
    @State private var entryImages: [Data]
    @State private var entryLocation: String?
    @State private var entryCreationDate: Date
    @State private var entryTrip: Trip?
    @State private var publishMessage: String?
    @State private var publishSuccess: Bool = true
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }
    
    init(entry: JournalEntry) {
        self.entry = entry
        entryTitle = entry.title
        entryText = entry.text
        entryImages = entry.images
        entryLocation = entry.location
        entryCreationDate = entry.creationDate
        entryTrip = entry.trip
    }
    
    init(trip: Trip) {
        entryTrip = trip
        entryTitle = ""
        entryText = ""
        entryImages = []
        entryLocation = ""
        entryCreationDate = Date()
    }
    
    var body: some View { // TODO: automatisch in edit modus umschalten!!!
        VStack(alignment: .leading) {
            if let message = publishMessage {
                Text(message)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(publishSuccess ? Color.accentColor : .red)
                    .padding()
            }
            DeactivableTextInput(label: "Title", placeholder: "Entry Title", text: $entryTitle)
                .padding()
            DeactivableTextInput(label: "Location", placeholder: "Location", text: $entryLocation).padding()
            DeactivableDatePicker(label: "Date",
                                  date: $entryCreationDate)
            .padding()
            DeactivableTextEditor(label: "Text",
                                  text: $entryText)
            .padding()
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 0){
                    ForEach(entryImages, id: \.self) { imageData in
                        if let image = Image(data: imageData) {
                            image.resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            PhotosPicker(selection: $selectedItems) {
                Text("Add Images")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(!isEditing)
            .onChange(of: selectedItems) { _ , newItems in
                addImageItemsFromPhotoPicker(items: newItems)
            }
        }
        .onAppear() {
            if entry == nil {
                editMode?.wrappedValue = .active
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem {
                Button(action: publishEntry) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }.disabled(isEditing || entry == nil)
            }
            ToolbarItem {
                Button(action: toggleEditMode) {
                    if editMode?.wrappedValue == .active {
                        Text(entry != nil ? "Save" : "Add").fontWeight(.bold)
                    } else {
                        Text("Edit").fontWeight(.regular)
                    }
                }
            }
        }
        .onChange(of: isEditing) { _, newValue in
            if !isEditing {
                updateEntry()
            }
        }
        .navigationTitle("Journal Entry")
        
    }
    
    private func addImageItemsFromPhotoPicker(items: [PhotosPickerItem]) {
        Task {
            var imagesData: [Data] = []
            
            for item in items {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    imagesData.append(data)
                }
            }
            selectedItems = []
            if !imagesData.isEmpty {
                imagesData.forEach {
                    entryImages.append($0)
                }
            }
        }
    }
    
    private func toggleEditMode() {
        withAnimation {
            if editMode?.wrappedValue == .active {
                editMode?.wrappedValue = .inactive
            } else {
                editMode?.wrappedValue = .active
            }
        }
    }
    
    func publishEntry() {
        Task {
            guard let entry = entry else { return }
            publishSuccess = await journalEntryApi.post(entry)
            if publishSuccess {
                publishMessage = "Entry published!"
            } else {
                publishMessage = "Entry could not be published!"
            }
        }
    }
    
    func updateEntry() {
        if let entry = entry {
            entry.title = entryTitle
            entry.text = entryText
            entry.images = entryImages
            entry.location = entryLocation
            entry.creationDate = entryCreationDate
        } else {
            guard let entryTrip else { return }
            let newEntry = JournalEntry(title: entryTitle, text: entryText, images: entryImages, location: entryLocation, creationDate: Date.now, trip: entryTrip)
            entryTrip.entries.append(newEntry)
            dismiss()
        }
    }
}

#Preview {
    var trip = Trip(name: "San Francisco", entries: [])
    trip.entries.append(JournalEntry(title: "Test in SF", text: "Es war sehr schön hier! 10/10, ich würde wieder kommen! 🌴", images: [], location: "Hofkirchen", creationDate: Date.now, trip: trip))
    return JournalEntryDetailView(entry: trip.entries.first!)
}
