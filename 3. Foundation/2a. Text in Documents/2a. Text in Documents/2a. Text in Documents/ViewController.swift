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
        tv.text = "Enter your text..."
        tv.layer.borderColor = UIColor.lightGray.cgColor
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
    
    private let appendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Append Text", for: .normal)
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
        let stack = UIStackView(arrangedSubviews: [textView, saveButton, appendButton, loadButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fileName: String = "text_file5.txt"
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        self.title = "Text in Documents"
        view.backgroundColor = .systemBackground
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            textView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        appendButton.addTarget(self, action: #selector(appendButtonTapped), for: .touchUpInside)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        saveText()
    }
    @objc private func appendButtonTapped() {
        appendText()
    }
    @objc private func loadButtonTapped() {
        loadText()
    }
    
    private func saveText() {
        let text = textView.text ?? ""
        guard let url = fileURL else { return }
        
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            textView.text = ""
            showAlert(title: "Success", message: "Text saved!")
        } catch {
            showAlert(title: "Error", message: "Failed to save the text: \(error.localizedDescription)")
        }
        
    }
    private func appendText() {
        guard let url = fileURL, FileManager.default.fileExists(atPath: url.path) else {
            showAlert(title: "Error", message: "Failed to find the file URL.")
            return
        }
        
        guard var textToAppend = textView.text, !textToAppend.isEmpty else {
            showAlert(title: "Info", message: "Text view is empty.")
            return
        }
        
        guard let data = textToAppend.data(using: .utf8) else {
            showAlert(title: "Error", message: "Failed to convert text to data.")
            return
        }
        
        do {
            let fileHandle = try FileHandle(forUpdating: url)
            try fileHandle.seekToEnd()
            try fileHandle.write(contentsOf: data)
            fileHandle.closeFile()
            
            textView.text = ""
            
            showAlert(title: "Success", message: "Text appended to file!")
        } catch {
            showAlert(title: "Error", message: "Failed to append text: \(error.localizedDescription)")
        }
    }
    
    private func loadText() {
        guard let url = fileURL, FileManager.default.fileExists(atPath: url.path) else {
            showAlert(title: "Error", message: "Could not find the file URL.")
            
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

