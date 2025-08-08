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
        ZStack(alignment: .center){
            if myExample.isPremium {
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 80))
                    Text("Premium Badge")
                        .font(.headline)
                }
                .offset(x:0, y:-200)
            }
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.gray)
                    VStack(alignment: .leading) {
                        Text(myExample.name)
                            .font(.headline)
                        Text("Age: \(myExample.age), \(myExample.location)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                Toggle("isPremium", isOn: $myExample.isPremium)
                    .toggleStyle(.switch)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
