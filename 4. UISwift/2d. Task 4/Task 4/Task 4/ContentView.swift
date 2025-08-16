//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Bednarz on 06/08/2025.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    var activeColor: Color = .green
    var labelText: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(configuration.isOn ? activeColor : Color(.systemGray))
                    .frame(width: 50, height: 32)
                Circle()
                    .fill(.white)
                    .frame(width: 26, height: 26)
                    .padding(3)
            }
            .accessibilityLabel(labelText)
            .accessibilityValue(configuration.isOn ? "On" : "Off")
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var isDarkModeEnabled = true
    var body: some View {
        Toggle("Dark Mode", isOn: $isDarkModeEnabled)
            .toggleStyle(MyToggleStyle(labelText: "Dark Mode"))
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
            .padding()
    }
    
}

#Preview {
    ContentView()
}
