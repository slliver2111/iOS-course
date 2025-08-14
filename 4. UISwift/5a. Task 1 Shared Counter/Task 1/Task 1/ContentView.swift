//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 14/08/2025.
//

import SwiftUI

final class Counter: ObservableObject {
    @Published var counterValue = 0
}

struct ContentView: View {
    @StateObject private var counter = Counter()
    
    var body: some View {
        VStack {
            CounterDisplayView()
            IncrementCounterView()
            DecrementCounterView()
        }
        .padding()
        .environmentObject(counter)
    }
}

struct CounterDisplayView: View {
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        Text("Current value: \(counter.counterValue)")
    }
}

struct IncrementCounterView: View {
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        Button("+1") {counter.counterValue += 1}
            .buttonStyle(.borderedProminent)
    }
}

struct DecrementCounterView: View {
    @EnvironmentObject private var counter: Counter
    
    var body: some View {
        Button("-1") {counter.counterValue -= 1}
            .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ContentView()
}
