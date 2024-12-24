//
//  JournalEntryApi.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

import Foundation

final class PublicJournalEntryApi {
    let baseUrl: String = "https://travel-diary.moetz.dev/api/v1"
    
    func getAll() async -> [PublicJournalEntryDto]? {
        guard let url = URL(string: baseUrl + "/diary") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601withOptionalFractionalSeconds
            let entries = try decoder.decode([PublicJournalEntryDto].self, from: data)
            return entries
        } catch {
            print(error)
            return nil
        }
    }
    
    func post(_ entry: JournalEntry) async -> Bool {
        guard let url = URL(string: baseUrl + "/diary") else { return false }
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(PostPublicJournalEntryDto(from: entry))
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (responseMessage, response) = try await URLSession.shared.upload(for: request, from: data)
            guard let httpResponse = response as? HTTPURLResponse else { return false }
            print("StatusCode is \(httpResponse.statusCode)")
            if let str = String(data: responseMessage, encoding: .utf8) {
                print(str)
            }
            return httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        } catch {
            print(error)
            return false
        }
    }
    
}
