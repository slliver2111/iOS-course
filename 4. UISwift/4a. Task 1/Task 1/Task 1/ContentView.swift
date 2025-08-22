//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Counter: \(counter)")
                .font(Font.system(size: 26))
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
