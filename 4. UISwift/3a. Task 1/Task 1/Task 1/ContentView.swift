//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Bednarz on 09/08/2025.
//

import SwiftUI

let backgroundGradient1 = LinearGradient(
    colors: [Color.red, Color.orange],
    startPoint: .top, endPoint: .bottom
)

let backgroundGradient2 = LinearGradient(
    colors: [Color.purple, Color.blue],
    startPoint: .bottom, endPoint: .top
)

let backgroundGradient3 = LinearGradient(
    colors: [Color.yellow, Color.white],
    startPoint: .leading, endPoint: .bottom
)

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI Layout Modifiers")
                .padding(16)
                .background(backgroundGradient1)
            
            Text("SwiftUI Layout Modifiers")
                .padding([.trailing, .leading], 16)
                .background(Color.green)
                .border(Color.black)
            
            Text("SwiftUI Layout Modifiers")
                .border(Color.black)
                .padding([.bottom, .top], 16)
                .background(backgroundGradient3)
        }
    }
}

#Preview {
    ContentView()
}
