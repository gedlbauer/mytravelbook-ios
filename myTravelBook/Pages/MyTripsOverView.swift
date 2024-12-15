//
//  MyTripsOverView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 15.12.24.
//

import SwiftUI
import SwiftData

struct MyTripsOverView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var tripToAdd: Trip? =  Trip(name:"")
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(trips) { trip in
                    NavigationLink {
                        Text("Item at \(trip.name)")
                    } label: {
                        Text(trip.name)
                    }
                }
                .onDelete(perform: deleteTrip)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {tripToAdd = Trip(name: "")}) {
                        Label("Add Trip", systemImage: "plus")
                    }.sheet(item: $tripToAdd){ trip in
                        NavigationView {
                            VStack {
                                LabeledContent{
                                    TextField("Enter the name of your trip here", text: Binding(
                                        get: { trip.name },
                                        set: { trip.name = $0 }
                                    ))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                } label : { Text("Trip Name") }
                                    .padding()
                            }.frame(maxHeight: .infinity, alignment: .topLeading)
                            .navigationTitle("Add Trip")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        tripToAdd = nil
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        if let newTrip = tripToAdd {
                                            modelContext.insert(newTrip)
                                            tripToAdd = nil
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func deleteTrip(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    MyTripsOverView()
        .modelContainer(for: Trip.self, inMemory: true)
}
