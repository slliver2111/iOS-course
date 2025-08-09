//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Bednarz on 10/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("SwiftUI is amazing!")
            .frame(width: 175, height: 100)
            .background(.gray)
            .overlay {
                Circle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .opacity(0.5)
            }
            .clipShape(Circle())
    }
}

#Preview {
    ContentView()
}


