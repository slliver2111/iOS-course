//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
            Button("+1") {
                counter += 1
            }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
