//
//  ViewController.swift
//  3a. Custom Notification
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class ReceiverViewController: UIViewController {
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for notification"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Receiver"
        setupUI()
        addObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI(){
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTask(notification:)),
            name: .myMessageSent,
            object: nil
        )
    }
    
    @objc private func handleTask(notification: Notification) {
        guard let msg = notification.userInfo?[NotificationKeys.myMessage] as? String else {
            print("Error with receiving notification")
            return
        }
        
        DispatchQueue.main.async {
            self.statusLabel.text = msg
            print("Label text updated on main thread.")
        }
    }
}
