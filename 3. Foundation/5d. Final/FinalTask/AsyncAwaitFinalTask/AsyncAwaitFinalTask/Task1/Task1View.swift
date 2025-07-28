//
//  SwiftUIView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task1View: View, @unchecked Sendable {
    let task1API = Task1API()
    @State var fact = "To get random number fact presss button below"
    
    var body: some View {
        VStack {
            Text(fact)
                .padding()
            Button(action: {
                Task {
                    do {
                        let newFact = try await task1API.getTrivia(for: nil)
                        self.fact = newFact
                    } catch {
                        self.fact = "loading error: \(error.localizedDescription)"
                    }
                }
            }, label: { Text("Click me") })
        }
    }
}

class Task1API: @unchecked Sendable {
    let baseURL = "http://numbersapi.com"
    let triviaPath = "random/trivia"
    private var session = URLSession.shared
    
    enum APIError: Error {
        case urlError
        case decodingError
    }
    
    func getTrivia(for number: Int?) async throws -> String {
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            throw APIError.urlError
        }
        print(url)
        
        let (data, _) = try await session.data(from: url)
        
        guard let randomFact = String(data: data, encoding: .utf8) else {
            throw APIError.decodingError
        }
        
        return randomFact
    }
}


#Preview {
    Task1View()
}
