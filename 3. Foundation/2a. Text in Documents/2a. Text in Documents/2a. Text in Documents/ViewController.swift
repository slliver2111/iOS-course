//
//  ViewController.swift
//  2a. Text in Documents
//
//  Created by Artur Bednarz on 09/07/2025.
//

import UIKit

class ViewController: UIViewController {
    private let textView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save Text", for: .normal)
        return button
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Load Text", for: .normal)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textView, saveButton, loadButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fileName: String = "test.txt"
    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Text to/from Documents"
        view.backgroundColor = .systemBackground
        //saveText("Hello, I wish to become ios developer", to: "test.txt")
        
        view.addSubview(mainStack)
        
        saveButton.addTarget(self, action: #selector(saveText), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadText), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func saveText() {
        let text = textView.text ?? "no text entered"
        guard let url = fileURL else {return}
        
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            showAlert(title: "Success", message: "Text saved!")
        } catch {
            showAlert(title: "Error", message: "Failed to save text: \(error)")
        }
    }
    
    @objc private func loadText() {
        guard let url = fileURL else {return}
        
        do {
            let text = try String(contentsOf: url, encoding: .utf8)
            textView.text = text
            showAlert(title: "Success", message: "Text loaded seccessfuly!")
        } catch {
            showAlert(title: "Error", message: "Failed to save text: \(error)")
        }
    }
}

