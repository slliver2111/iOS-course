//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = true
    
    var body: some View {
        VStack {
            Toggle("Text is displayed", isOn: $isActive)
            if isActive {
                Text("Hello, SwiftUI!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
