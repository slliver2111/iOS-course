//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields
final class Task3ViewController: UIViewController {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton()

    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestures()
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupView() {
        setupContentView()
        setupLabels()
        setupTextFields()
        setupButton()
        setupConstraints()
    }
    
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor)
            ]
        )
    }
    
    private func setupLabels() {
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)

        bodyLabel.numberOfLines = 0
        bodyLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore
        """
        bodyLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setupTextFields() {
        usernameField.placeholder = "Enter username"
        usernameField.borderStyle = .roundedRect
        usernameField.setContentHuggingPriority(.required, for: .vertical)

        passwordField.borderStyle = .roundedRect
        passwordField.placeholder = "Enter password"
        passwordField.setContentHuggingPriority(.required, for: .vertical)
        
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
    }
    
    private func setupButton() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.tintColor, for: .normal)
        contentView.addSubview(logInButton)
    }
    
    private func setupConstraints() {
        setupLabelsConstraints()
        setupTextFieldsConstraints()
        setupButtonConstraints()
    }
    
    private func setupLabelsConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 40),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ]
        )
    }
    
    private func setupTextFieldsConstraints() {
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40),
            usernameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            usernameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

#Preview {
    Task3ViewController()
}
