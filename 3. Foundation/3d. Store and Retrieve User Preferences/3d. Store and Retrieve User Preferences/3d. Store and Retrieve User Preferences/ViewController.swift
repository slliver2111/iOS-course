//
//  ViewController.swift
//  3d. Store and Retrieve User Preferences
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class UserViewController: UIViewController {
    private let darkModeLabel = UILabel()
    private let darkModeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBackgroundPreference()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        darkModeLabel.text = "Dark Mode"
        
        let hStack = UIStackView(arrangedSubviews: [darkModeLabel, darkModeSwitch])
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.spacing = 8
        
        view.addSubview(hStack)
        
        darkModeSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func loadBackgroundPreference() {
        let isDark = UserDefaults.standard.bool(forKey: "is_dark")
        changeBackground(isDark: isDark)
        darkModeSwitch.setOn(isDark, animated: false)
    }
    
    private func changeBackground(isDark: Bool) {
        let style: UIUserInterfaceStyle = isDark ? .dark : .light
        overrideUserInterfaceStyle = style
    }
    
    @objc private func switchToggled(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.set(isDark, forKey: "is_dark")
        changeBackground(isDark: isDark)
    }
}

