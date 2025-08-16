//
//  ViewController.swift
//  Task 1 Interoper
//
//  Created by Artur Bednarz on 16/08/2025.
//

import UIKit
import SwiftUI

final class UserViewController: UIViewController {
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis =  .vertical
        sv.spacing = 16
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello UIKit"
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Switch to SwiftUI", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    
    @objc private func buttonTapped() {
        let swiftUIView = SwiftUIView()
        let host = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(host, animated: true)
    }

}



#Preview {
    UserViewController()
}
