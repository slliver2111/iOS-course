//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Bednarz on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.gray)
            VStack(alignment: .leading) {
                Text("Artur Bednarz")
                    .font(.headline)
                Text("iOS Developer")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
