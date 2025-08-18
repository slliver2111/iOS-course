//
//  ViewController.swift
//  Task 2 Interoper
//
//  Created by Artur Bednarz on 17/08/2025.
//

import UIKit

class UserViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainLabel = UILabel()
        mainLabel.text = "Hello, from UIKit!"
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}



#Preview {
    UserViewController()
}
