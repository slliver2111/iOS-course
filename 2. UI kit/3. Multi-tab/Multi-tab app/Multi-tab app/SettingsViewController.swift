//
//  SettingsViewController.swift
//  Multi-tab app
//
//  Created by Artur Bednarz on 20/06/2025.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        setupLayout()
    }
    
    private let textField: UILabel = {
        let text = UILabel()
        text.text = "Navigation is easy!"
        text.font = .systemFont(ofSize: 24, weight: .bold)
        text.textAlignment = .center
        return text
    }()
    
    private let myToggle: UISwitch = {
        let mySwitch = UISwitch()
        return mySwitch
    }()
    
    private func setupLayout() {
        myToggle.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myToggle)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            myToggle.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            myToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


#Preview {
    SettingsViewController()
}
