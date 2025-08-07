//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Bednarz on 06/08/2025.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    var activeColor: Color = .green
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : Color(.systemGray))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                    
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ContentView: View {
    private var myToggleStyle = MyToggleStyle()
    @State private var isDarkModeEnabled = true
    var body: some View {
        HStack {
            Toggle("Dark Mode", isOn: $isDarkModeEnabled)
        }
        .toggleStyle(myToggleStyle)
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
    }
    
}

#Preview {
    ContentView()
}
