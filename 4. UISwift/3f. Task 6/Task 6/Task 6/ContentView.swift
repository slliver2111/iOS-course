//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Bednarz on 12/08/2025.
//

import SwiftUI

struct MyButtonModifier: ViewModifier {
    var isEnabled = false
    
    func body(content: Content) -> some View {
        content
            .padding()
            .font(Font.body)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .opacity(isEnabled ? 1 : 0.5)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Active button") {}
                .modifier(MyButtonModifier(isEnabled: true))
            
            Button("Disabled button") {}
                .modifier(MyButtonModifier(isEnabled: false))
                .disabled(true)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
