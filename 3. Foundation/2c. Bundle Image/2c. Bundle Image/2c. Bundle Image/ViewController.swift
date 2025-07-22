//
//  ViewController.swift
//  2c. Bundle Image
//
//  Created by Artur Bednarz on 22/07/2025.
//

import UIKit

struct AppConfig: Decodable {
    let title: String
    let settings: AppSettings
}

struct AppSettings: Decodable {
    let fileNames: [String]
    let backgroundColor: String
}

class ViewController: UIViewController {
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let configName = "config"
    private let configExtension = "json"

    override func viewDidLoad() {
        super.viewDidLoad()
        if let config = getBundledJSONConfig() {
            setupUI(with: config)
        }
    }
    
    private func getBundledJSONConfig() -> AppConfig? {
        if let config = parseConfig() {
            return config
        } else {
            showAlert(title: "Error", message: "Something went wrong with parsing. Check logs")
            return nil
        }
    }
    
    private func parseConfig() -> AppConfig? {
        guard let url = Bundle.main.url(forResource: configName, withExtension: configExtension) else {
            print("Error with url")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            print(url)
            let config = try JSONDecoder().decode(AppConfig.self, from: data)
            return config
        } catch {
            print("Error with parsing")
            return nil
        }
    }
    
    private func setupUI(with appConfig: AppConfig) {
        self.title = appConfig.title
        view.backgroundColor = UIColor(named: appConfig.settings.backgroundColor)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let imgNames = appConfig.settings.fileNames
        
        for imgName in imgNames {
            guard let img = UIImage(named: imgName) else {
                print("Error with loading \(imgName).")
                continue
            }
            let iv = UIImageView(image: img)
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 8
            
            NSLayoutConstraint.activate([
                iv.heightAnchor.constraint(equalToConstant: 180)
            ])
            
            stackView.addArrangedSubview(iv)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

