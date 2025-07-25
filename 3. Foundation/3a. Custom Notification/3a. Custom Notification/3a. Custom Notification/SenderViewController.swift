//
//  ViewController.swift
//  3a. Custom Notification
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class SenderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sender"
        setupUI()
    }
    
    private func setupUI(){
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Click button to send notification"
        
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func sendButtonTapped() {
        NotificationCenter.default.post(
            name: Notification.Name("MyNotification"),
            object: nil,
            userInfo: ["myKey": "Hello iOS world!"]
        )
        
        let alert = UIAlertController(title: "Success", message: "Notification posted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
