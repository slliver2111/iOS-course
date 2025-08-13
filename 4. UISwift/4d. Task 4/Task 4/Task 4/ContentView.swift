//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

@Observable
final class ProfileModel {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

struct ContentView: View {
    @State private var model = ProfileModel(name: "Artur", email: "artur@epam.com")
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Real time name: \(model.name)")
            Text("Real time email: \(model.email)")
            TextField("Enter text", text: $model.name)
                .textFieldStyle(.roundedBorder)
            TextField("Enter text", text: $model.email)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
