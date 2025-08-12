//
//  ContentView.swift
//  Task 2N
//
//  Created by Artur Bednarz on 12/08/2025.
//

import SwiftUI

struct SettingsRoute: Hashable { let id: UUID }
struct ProfileRoute: Hashable { let id: UUID }

struct HomeView: View {
    @State private var path = NavigationPath()
    
    private let settingsRoute = SettingsRoute(id: UUID())
    
    var body: some View {
        NavigationStack(path: $path){
            Button("Go to Settings") { path.append(settingsRoute) }
                .navigationDestination(for: SettingsRoute.self) {_ in
                    SettingsView(path: $path)
                }
                .navigationDestination(for: ProfileRoute.self) {_ in
                    ProfileView(path: $path)
                }
                .navigationTitle("Home")
        }
    }
}

struct SettingsView: View {
    @Binding var path: NavigationPath
    
    private let profileRoute = ProfileRoute(id: UUID())
    
    var body: some View {
        Button("Go to Profile") {
            path.append(profileRoute)
        }
        .navigationTitle("Settings")
    }
}

struct ProfileView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Button("Go to Home") { path = .init() }
            .navigationTitle("Profile")
    }
}


#Preview {
    HomeView()
}
