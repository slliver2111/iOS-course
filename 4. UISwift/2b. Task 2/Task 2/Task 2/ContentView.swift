//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Bednarz on 05/08/2025.
//

import SwiftUI

struct Person: Identifiable {
    var id = UUID()
    let name: String
}

struct ContentView: View {
    let listOfPeople = [
        Person(name: "Artur"),
        Person(name: "Pawel"),
        Person(name: "Ola"),
        Person(name: "Kinga"),
        Person(name: "Natalia"),
    ]
    
    var body: some View {
        List(listOfPeople) { person in
            HStack {
                Text(person.name)
                Spacer()
                Button("Tap") { print(person.name) }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
