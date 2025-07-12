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
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return tv
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save Text", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Load Text", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textView, saveButton, loadButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fileName: String = "text_file.txt"
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentsDirectory.appendingPathComponent(fileName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        loadText(AlertToShow: false)
    }
    
    private func setupUI() {
        self.title = "Text to/from Documents"
        view.backgroundColor = .systemBackground
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        saveText()
    }
    @objc private func loadButtonTapped() {
        loadText(AlertToShow: true)
    }

    private func saveText() {
        let text = textView.text ?? "no text entered"
        guard let url = fileURL else {return}
        
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            showAlert(title: "Success", message: "Text saved!")
        } catch {
            showAlert(title: "Error", message: "Failed to save the text: \(error.localizedDescription)")
        }
    }
    
    private func loadText(AlertToShow: Bool) {
        guard let url = fileURL, FileManager.default.fileExists(atPath: url.path) else {
            if AlertToShow {
                showAlert(title: "Not found", message: "Saved text file not found")
            }
            return
        }
        do {
            let text = try String(contentsOf: url, encoding: .utf8)
            textView.text = text
            showAlert(title: "Success", message: "Text loaded seccessfully!")
        } catch {
            showAlert(title: "Error", message: "Failed to load the text: \(error.localizedDescription)")
        }
    }
}

