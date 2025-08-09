//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Bednarz on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .padding(.all, 40)
    }
}

#Preview {
    ContentView()
}
