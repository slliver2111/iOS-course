//
//  ViewController.swift
//  4. Image Display
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Hello world!"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello world!"
        view.backgroundColor = .systemGray
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            userLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }


}

