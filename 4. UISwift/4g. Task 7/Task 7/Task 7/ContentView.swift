//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

@Observable
final class Counter {
    var value = 0
}

struct ContentView: View {
    @State private var counter = Counter()
    
    var body: some View {
        HStack {
            VStack {
                Text("Counter Main: \(counter.value)")
                Button("+1") {
                    counter.value += 1
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            SiblingView(counter: counter)
        }
    }
}

struct SiblingView: View {
    let counter: Counter
    
    var body: some View {
        VStack {
            Text("Counter Main: \(counter.value)")
            Button("-1") {
                counter.value -= 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
