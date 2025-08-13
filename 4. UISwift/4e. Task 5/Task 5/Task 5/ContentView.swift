//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Bednarz on 13/08/2025.
//

import SwiftUI

@Observable
class FormModel {
    var username: String
    var email: String
    
    init(username: String = "", email: String = "") {
        self.username = username
        self.email = email
    }
}

struct ContentView: View {
    @State private var model = FormModel()
    
    var body: some View {
        Form() {
            Section(header: Text("Registration")){
                TextField(text: $model.username, prompt: Text("Username")) {
                    Text("Username")
                }
                TextField(text: $model.email, prompt: Text("Email")) {
                    Text("Password")
                }
                Button("Submit") {}
                    .disabled(model.username.isEmpty)
            }
        }
        
    }
}

#Preview {
    ContentView()
}

//Create a simple form with a text input (e.g., email or username). Create @Observable FormModel which is stored in a view @state private var. Make text field to display/update `username` var stored in FormModel. Add a submit button that is enabled when `username` is not empty
