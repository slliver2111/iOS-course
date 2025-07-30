//
//  MainViewController.swift
//  3e. Simple Login Persistence System
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class MainViewController: UIViewController {
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, logoutButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayUserInfo()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Welcome Screen"
        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func displayUserInfo() {
        if let username = UserDefaults.standard.string(forKey: "username") {
            welcomeLabel.text = "Hello, \(username)!"
        }
    }

    @objc private func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "username")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.showLoginScreen()
    }
}
