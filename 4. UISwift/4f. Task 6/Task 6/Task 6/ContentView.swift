//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

struct Setting: Identifiable {
    var id = UUID()
    let name: String
    var isActive: Bool
}

struct ContentView: View {
    @State private var settings = [
        Setting(name: "Dark mode", isActive: false),
        Setting(name: "Silent mode", isActive: false),
        Setting(name: "Airplane mode", isActive: true),
    ]
    
    var body: some View {
        Form () {
            ForEach($settings) { $setting in
                Toggle(setting.name, isOn: $setting.isActive)
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//Create a list of settings using an array of custom structs. Each item has a name and a `Bool` flag. Use `@State` to track the array and display toggles for each item that update their state.
