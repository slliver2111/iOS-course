//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Bednarz on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 100)
            .offset(x: -180, y: -400)
        Rectangle()
            .fill(.red)
            .frame(width: 100, height: 50)
            .offset(x: -100, y: -350)
        
    }
}

#Preview {
    ContentView()
}
