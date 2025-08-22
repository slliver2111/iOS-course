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
    @State private var model = ProfileModel(name: "", email: "")
    
    var body: some View {
        Form {
            Section("Sign Up") {
                Text("Real time name: \(model.name)")
                Text("Real time email: \(model.email)")
                TextField("Name", text: $model.name)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                TextField("Email", text: $model.email)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
