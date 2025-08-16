//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Bednarz on 06/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.gray)
                .font(Font.system(size: 30))
            VStack(alignment: .leading) {
                Text("Artur Bednarz")
                    .font(.headline)
                Text("iOS Developer")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
