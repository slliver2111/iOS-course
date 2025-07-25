//
//  ViewController.swift
//  3a. Observe and Handle Keyboard Events
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

class myViewController: UIViewController {
    private let textField = UITextField()
    private var bottomTextContraint: NSLayoutConstraint! //create reference
    
    private let safeMargin = CGFloat(20)
    private let textViewHeight = CGFloat(40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        addKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        textField.placeholder = "Tap me!"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        bottomTextContraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -safeMargin)
    
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: safeMargin),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -safeMargin),
            textField.heightAnchor.constraint(equalToConstant: textViewHeight),
            
            bottomTextContraint
        ])
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil,
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil,
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardsFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            print("Error")
            return
        }
        bottomTextContraint.constant = -keyboardsFrame.height - safeMargin
        view.layoutIfNeeded()
        print("Keyboard showed")
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomTextContraint.constant = -safeMargin
        view.layoutIfNeeded()
        print("Keyboard hide")
    }
}

