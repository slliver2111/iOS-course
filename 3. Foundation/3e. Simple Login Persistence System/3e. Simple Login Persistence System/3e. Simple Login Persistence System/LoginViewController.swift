//
//  ViewController.swift
//  3e. Simple Login Persistence System
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class LoginViewController: UIViewController {    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter username..."
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Login"
        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            print("Username is required.")
            return
        }
    
        UserDefaults.standard.set(true, forKey: "isLoggedin")
        UserDefaults.standard.set(username, forKey: "username")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.showMainScreen()
    }
}
