//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 05/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var greetingShown = false
    
    var body: some View {
        VStack {
            Toggle("Show Greeting", isOn: $greetingShown)
            if greetingShown {
                Text("Hello, SwiftUI!").font(.title)
            }
        }
    }
}

#Preview {
    ContentView()
}
