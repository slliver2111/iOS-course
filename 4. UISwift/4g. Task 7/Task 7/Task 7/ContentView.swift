//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

@Observable
class Counter {
    var counter = 0
}

struct ContentView: View {
    @State var counter = Counter()
    
    var body: some View {
        HStack {
            VStack {
                Text("Counter Main: \(counter.counter)")
                Button("+1") {
                    counter.counter += 1
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            SiblingView(counter: counter)
        }
    }
}

struct SiblingView: View {
    @Bindable var counter: Counter
    
    var body: some View {
        VStack {
            Text("Counter Main: \(counter.counter)")
            Button("-1") {
                counter.counter -= 1
            }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
