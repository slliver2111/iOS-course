//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 05/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isGreetingShown = false
    
    var body: some View {
        VStack {
            Toggle("Show Greeting", isOn: $isGreetingShown)
            if isGreetingShown {
                Text("Hello, SwiftUI!").font(.title)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
