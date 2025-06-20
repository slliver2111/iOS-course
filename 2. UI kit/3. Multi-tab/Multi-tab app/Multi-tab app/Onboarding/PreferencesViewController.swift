//
//  PreferencesViewController.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 19/06/2025.
//

import UIKit

class PreferencesViewController: UIViewController {
    var userData: UserData
    
    init (userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum UserNotificationPreference: String, CaseIterable{
        case Email = "Email Notifications", SMS = "SMS Notifications", Push = "Push Notifications"
    }
    
    private let stackView = UIStackView()
    private lazy var userButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Notification Preference"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        config.cornerStyle = .dynamic
        button.configuration = config
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        setupLayout()
        //showActionSheet()
        refreshLabel()
    }
    
    private func setupLayout() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(userButton)
        stackView.addArrangedSubview(userLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func showActionSheet() {
        let alert = UIAlertController(title: "Select Notification Preference", message: "Please select how do you want to receive notifations.", preferredStyle: .actionSheet)
        for pref in UserNotificationPreference.allCases {
            alert.addAction(UIAlertAction(title: pref.rawValue, style: .default, handler: {_ in self.userData.notificationPreference = pref;self.refreshLabel();self.goToConfirmDetails()}))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func refreshLabel() {
        userLabel.text =  "Current choice: " + userData.notificationPreference.rawValue
    }
    
    @objc private func goToConfirmDetails() {
        let confirmDetailsVC = ConfirmDetailsViewController(userData: userData)
        navigationController?.pushViewController(confirmDetailsVC, animated: false)
    }
}

#Preview {
    PreferencesViewController(userData: UserData())
}
