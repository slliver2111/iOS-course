//
//  ViewController.swift
//  URL Requests
//
//  Created by Artur Bednarz on 06/07/2025.
//

import UIKit

class UserViewController: UIViewController {
    var usersArray: [User] = []
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tv.alpha = 0
        return tv
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "User table"
        
        view.addSubview(tableView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        Task {
            defer {
                stopAnimationSpinner()
            }
            await fetchData()
        }
    }
    
    func fetchData() async {
        self.startAnimationSpinner()
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            showAlert(data: "Wrong URL")
            return
        }
        
        do {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                showAlert(data: "Server issue")
                return
            }
            
            self.usersArray = try JSONDecoder().decode([User].self, from: data)
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                })
            }
            
        } catch {
            print("Error getting data \(error)")
            showAlert(data: error.localizedDescription)
        }
    }
    
    private func showAlert(data: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: data, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func startAnimationSpinner() {
        DispatchQueue.main.async {
            self.tableView.alpha = 0
            self.spinner.startAnimating()
        }
    }
    
    private func stopAnimationSpinner() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        let user = usersArray[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = user.name
        config.secondaryText = user.email
        
        cell.contentConfiguration = config
        
        return cell
    }
}
