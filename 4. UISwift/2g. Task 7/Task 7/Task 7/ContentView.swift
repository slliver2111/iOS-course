//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Bednarz on 08/08/2025.
//

import SwiftUI

struct Person: Identifiable {
    var id = UUID()
    let name: String
    let age: Int
    let location: String
    var isPremium: Bool
}

struct ContentView: View {
    @State private var myExample = Person(name: "Artur Bendarz", age: 28, location: "Krakow ",isPremium: true)
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(Font.system(size: 26))
                    .foregroundStyle(.gray)
                    .overlay(alignment: .topTrailing) {
                        if myExample.isPremium {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundStyle(.yellow)
                                .offset(x: 80, y: -80)
                        }
                    }
                VStack(alignment: .leading) {
                    Text(myExample.name)
                        .font(.headline)
                    Text("Age: \(myExample.age), \(myExample.location)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            Toggle("isPremium", isOn: $myExample.isPremium)
                .toggleStyle(.switch)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
