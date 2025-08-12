//
//  ContentView.swift
//  Task 1N
//
//  Created by Artur Bednarz on 12/08/2025.
//

import SwiftUI

struct FirstRoute: Hashable { let id: UUID }
struct SecondRoute: Hashable { let id: UUID }

struct ContentView: View {
    @State private var path = NavigationPath()
    
    private let firstRoute = FirstRoute(id: UUID())
    private let secondRoute = SecondRoute(id: UUID())
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink(value: firstRoute) {
                Text("View 1")
                    .font(.largeTitle)
            }
            .navigationDestination(for: FirstRoute.self) {_ in
                VStack {
                    Text("Welcome")
                    Button("Go to second View!") {
                        path.append(secondRoute)
                    }
                }
                .navigationTitle("First")
            }
            .navigationDestination(for: SecondRoute.self) {_ in
                Text("Hello, SwiftUI Navigation!")
                    .navigationTitle("Second ")
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
