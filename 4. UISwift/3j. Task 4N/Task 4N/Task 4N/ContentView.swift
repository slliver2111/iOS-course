//
//  ContentView.swift
//  Task 4N
//
//  Created by Artur Bednarz on 12/08/2025.
//

import SwiftUI

struct SettingsRoute: Hashable { let id: UUID }

struct HomeView: View {
    @State private var path = NavigationPath()
    
    private let settingsRoute = SettingsRoute(id: UUID())
    
    var body: some View {
        NavigationStack(path: $path){
            Text("Welcome!")
                .navigationDestination(for: SettingsRoute.self) {_ in
                    SettingsView(path: $path)
                }
                .navigationTitle("My App")
                .toolbar{
                    Button("Settings"){ path.append(settingsRoute) }
                }
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.bar, for: .navigationBar)
        }
    }
}

struct SettingsView: View {
    @Binding var path: NavigationPath

    
    var body: some View {
        Text("Settings Screen")
        .navigationTitle("Shouldn't be displayed")
        .toolbarVisibility(.hidden)
    }
}


#Preview {
    HomeView()
}
