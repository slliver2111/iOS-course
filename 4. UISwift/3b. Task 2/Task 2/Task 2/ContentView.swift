//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Bednarz on 09/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(.red)
                .frame(width: 150, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Rectangle()
                .fill(.green)
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
