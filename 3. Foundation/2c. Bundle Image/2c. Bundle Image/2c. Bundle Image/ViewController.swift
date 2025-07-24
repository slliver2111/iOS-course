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
    let imgHeight: CGFloat
    let spacing: CGFloat
}

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
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
        view.backgroundColor = .systemBackground
        
        if let config = parseConfig() {
            setupUI(with: config)
        }
    }
    
    
    private func parseConfig() -> AppConfig? {
        guard let url = Bundle.main.url(forResource: configName, withExtension: configExtension) else {
            showError(msg: "Error with url")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            print(url)
            let config = try JSONDecoder().decode(AppConfig.self, from: data)
            return config
        } catch {
            showError(msg: "Error with parsing")
            return nil
        }
    }
    
    private func setupUI(with appConfig: AppConfig) {
        self.title = appConfig.title
        //stackView.backgroundColor = UIColor(named: appConfig.settings.backgroundColor)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // The scroll view is pinned to the main view's safe area.
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
        
        stackView.spacing = CGFloat(appConfig.settings.spacing)
    
        let imgNames = appConfig.settings.fileNames
        for imgName in imgNames {
            guard let img = UIImage(named: imgName) else {
                print("Error with loading \(imgName).")
                continue
            }
            let iv = UIImageView(image: img)
            iv.contentMode = .scaleAspectFit
            
            NSLayoutConstraint.activate([
                iv.heightAnchor.constraint(equalToConstant: CGFloat(appConfig.settings.imgHeight))
            ])
            
            stackView.addArrangedSubview(iv)
        }
    }
    
    private func showError(msg: String) {
        view.backgroundColor = .systemBackground
        let errorLabel = UILabel()
        errorLabel.text = msg
        errorLabel.textColor = .label
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

