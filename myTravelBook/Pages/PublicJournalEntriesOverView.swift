//
//  PublicJournalEntriesOverView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 15.12.24.
//

import SwiftUI

struct PublicJournalEntriesOverView: View {
    let journalEntryClient = PublicJournalEntryApi()
    @State var isLoading: Bool = false
    @State var journalEntries: [PublicJournalEntryDto]? = []
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let journalEntries {
                List {
                    ForEach(journalEntries) { journalEntry in
                        PublicJournalEntryListItem(entry: journalEntry)
                    }
                }
            } else {
                Text("The journal entries could not be loaded.")
            }
        }.onAppear {
            loadJournalEntries()
        }
    }
    
    private func loadJournalEntries() {
        Task {
            defer {
                isLoading = false
            }
            journalEntries = await journalEntryClient.getAll()
        }
    }
}

#Preview {
    PublicJournalEntriesOverView()
}
