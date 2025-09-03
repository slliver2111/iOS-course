//
//  ContentView.swift
//  MVVM
//
//  Created by Artur Bednarz on 02/09/2025.
//

import SwiftUI
import Combine

// MARK: - Model re-use
struct User { let name: String }

protocol Authing {
    func login(username: String, password: String) async throws -> User
}

final class AsyncMockAuth: Authing {
    enum AuthError: Error { case invalid }
    func login(username: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 600_000_000)
        guard username == "john", password == "secret" else { throw AuthError.invalid }
        return User(name: "John")
    }
}

// MARK: - ViewModel (no knowledge of View)
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var message: String?
    @Published var loggedInUser: User?

    var canLogin: Bool { !username.isEmpty && !password.isEmpty && !isLoading }

    private let auth: Authing
    init(auth: Authing = AsyncMockAuth()) { self.auth = auth }

    func login() {
        guard canLogin else {
            message = "Fill in all fields"
            return
        }
        message = nil
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                let user = try await auth.login(username: username, password: password)
                loggedInUser = user
                message = "Welcome, \(user.name)!"
            } catch {
                message = "Invalid credentials"
            }
        }
    }
}

// MARK: - SwiftUI View binds to ViewModel
struct LoginView: View {
    @StateObject private var vm = LoginViewModel()

    var body: some View {
        VStack(spacing: 12) {
            TextField("Username", text: $vm.username)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            if vm.isLoading { ProgressView() }

            Button("Log in") { vm.login() }
                .buttonStyle(.borderedProminent)
                .disabled(!vm.canLogin)

            if let message = vm.message {
                Text(message)
                    .foregroundStyle(message.starts(with: "Welcome") ? .primary : .secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
    }
}

#Preview {
    LoginView()
}
