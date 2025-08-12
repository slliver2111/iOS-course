//
//  ContentView.swift
//  Task 3N
//
//  Created by Artur Bednarz on 12/08/2025.
//

import SwiftUI

struct Fruit: Identifiable {
    let id: UUID
    let name: String
    let details: String
}

struct ContentView: View {
    private var fruits = [
        Fruit(id: UUID(), name: "Apple", details: "Apple is red"),
        Fruit(id: UUID(), name: "Banana", details: "Banana is yellow"),
        Fruit(id: UUID(), name: "Cherry", details: "Cherry is red"),
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruits) {fruit in
                    NavigationLink(fruit.name) {
                        DetailView(fruit: fruit)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct DetailView: View {
    private let fruit: Fruit
    @State var isSheetPresented: Bool = false
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    var body: some View {
        Button("Show details") {
            isSheetPresented = true
        }
            .navigationTitle("Details")
            .sheet(isPresented: $isSheetPresented) {
                Text(fruit.details)
            }
    }
}

#Preview {
    ContentView()
}
