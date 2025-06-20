//
//  ConfirmDetailsViewController.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 20/06/2025.
//


import UIKit

class ConfirmDetailsViewController: UIViewController {
    var userData: UserData
    
    init (userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userLabel = UILabel()
    private let startButton = UIButton()
    private let editPrefButton = UIButton()
    private let editPersButton = UIButton()
    private let confirmButton = UIButton()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "Confirm details"
        setupLayout()
    }
    
    private func setupLayout() {
        userLabel.numberOfLines = 0
        userLabel.text = "Name: \(userData.name)\nPhone Number: \(userData.phoneNumber)\nNotification Preference: \(userData.notificationPreference)"
        stackView.addArrangedSubview(userLabel)
        
        startButton.setTitle("Start Over", for: .normal)
        startButton.addTarget(self, action: #selector(startOverTapped), for: .touchUpInside)
        editPrefButton.setTitle("Edit preferences", for: .normal)
        editPrefButton.addTarget(self, action: #selector(editPreferenceTapped), for: .touchUpInside)
        editPersButton.setTitle("Edit personal info", for: .normal)
        editPersButton.addTarget(self, action: #selector(editPersonalTapped), for: .touchUpInside)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        [startButton, editPrefButton, editPersButton, confirmButton].forEach({
            var config = UIButton.Configuration.filled()
            config.title = "Notification Preference"
            config.baseBackgroundColor = .systemBlue
            config.baseForegroundColor = .white
            config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
            config.cornerStyle = .dynamic
            $0.configuration = config
            stackView.addArrangedSubview($0)
        })
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        //stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            editPersButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            editPersButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            editPrefButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            editPrefButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func startOverTapped() {
        userData.reset()
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func editPersonalTapped() {
        if let targetVC = navigationController?.viewControllers.dropLast(2).last {
            navigationController?.popToViewController(targetVC, animated: false)
        }
    }
    
    @objc private func editPreferenceTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func confirmTapped() {
        let userAlert = UIAlertController(title: "Congrats!", message: "You have successfully passed the onboarding.", preferredStyle: .alert)
        userAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.startOverWithResetButton()}))
        present(userAlert, animated: true)
    }
    
    private func startOverWithResetButton() {
        userData.onBoardingFinished = true
        self.startOverTapped()
    }
}

#Preview {
    ConfirmDetailsViewController(userData: UserData())
}
