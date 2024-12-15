//
//  WelcomeView.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 14.12.24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
            NavigationView {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accentColor)
                    
                    // Localization is handeled by the Localizable String Catalog and happens automatically
                    Text("Welcome to myTravelBook")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("Create trips, add journal entries, and share your memories with the world.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()

                    NavigationLink(destination: ContentView()) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding()
            }
        }
}

#Preview {
    WelcomeView()
}
