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
    @State private var tripToAdd: Trip? =  nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(trips) { trip in
                    NavigationLink {
                        TripDetailView(trip: trip)
                    } label: {
                        Text(trip.name)
                    }
                }
                .onDelete(perform: deleteTrip)
            }
            .overlay{
                if trips.isEmpty {
                    Button("Add your first Trip"){
                        openAddTripDialog()
                    }
                }
            }
            .navigationTitle("My Trips")
            .animation(.easeInOut, value: trips.isEmpty)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: openAddTripDialog) {
                        Label("Add Trip", systemImage: "plus")
                    }
                }
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
                                    addTrip()
                                }
                            }
                        }
                }
            }
        }
    }
    
    private func openAddTripDialog() {
        tripToAdd = Trip(name: "")
    }
    
    private func addTrip() {
        guard let newTrip = tripToAdd else { return }
        modelContext.insert(newTrip)
        tripToAdd = nil
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
