//
//  ViewController.swift
//  MVP
//
//  Created by Artur Bednarz on 02/09/2025.
//

// MARK: - Model
struct User { let name: String }

protocol AuthService {
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}

final class MockAuthService: AuthService {
    enum AuthError: Error { case invalid }
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard username == "john", password == "secret" else { return completion(.failure(AuthError.invalid)) }
            completion(.success(User(name: "John")))
        }
    }
}

// MARK: - View (passive)
protocol LoginView: AnyObject {
    func setLoading(_ loading: Bool)
    func setInputsEnabled(_ enabled: Bool)
    func showError(_ message: String)
    func showWelcome(for user: User)
}

// MARK: - Presenter (knows the View)
final class LoginPresenter {
    private weak var view: LoginView?
    private let auth: AuthService

    init(view: LoginView, auth: AuthService) {
        self.view = view
        self.auth = auth
    }

    func didTapLogin(username: String?, password: String?) {
        guard let u = username, let p = password, !u.isEmpty, !p.isEmpty else {
            view?.showError("Fill in all fields")
            return
        }
        view?.setInputsEnabled(false)
        view?.setLoading(true)
        auth.login(username: u, password: p) { [weak self] result in
            guard let self else { return }
            self.view?.setLoading(false)
            self.view?.setInputsEnabled(true)
            switch result {
            case .success(let user):
                self.view?.showWelcome(for: user)
            case .failure:
                self.view?.showError("Invalid credentials")
            }
        }
    }
}

// MARK: - UIKit ViewController implements LoginView
import UIKit

final class LoginViewController: UIViewController, LoginView {
    private lazy var presenter = LoginPresenter(view: self, auth: MockAuthService())

    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let button = UIButton(type: .system)
    private let spinner = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect

        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect

        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, button, spinner, messageLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }

    @objc private func loginTapped() {
        presenter.didTapLogin(username: usernameField.text?.lowercased(), password: passwordField.text)
    }

    // MARK: - LoginView
    func setLoading(_ loading: Bool) {
        loading ? spinner.startAnimating() : spinner.stopAnimating()
    }
    func setInputsEnabled(_ enabled: Bool) {
        [usernameField, passwordField, button].forEach { $0.isUserInteractionEnabled = enabled }
        button.alpha = enabled ? 1 : 0.6
    }
    func showError(_ message: String) {
        messageLabel.textColor = .systemRed
        messageLabel.text = message
    }
    func showWelcome(for user: User) {
        messageLabel.textColor = .label
        messageLabel.text = "Welcome, \(user.name)!"
    }
}
