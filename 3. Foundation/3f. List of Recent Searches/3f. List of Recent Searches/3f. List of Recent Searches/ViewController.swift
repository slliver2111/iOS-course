//
//  ViewController.swift
//  3f. List of Recent Searches
//
//  Created by Artur Bednarz on 25/07/2025.
//

import UIKit

struct Keys {
    static let userSearchKey = "recent_searches"
}

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    // MARK: Properties
    private var searchStringArray: [String] = []
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Search for something..."
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        return tv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [searchBar, tableView])
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchStringArray = loadFromUserDefaults()
    }
    
    // MARK: Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Search Engine"
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    // MARK: Data handler
    private func loadFromUserDefaults() -> [String] {
        return UserDefaults.standard.stringArray(forKey: Keys.userSearchKey) ?? []
    }
    
    private func updateLastSearchArray(_ text: String) {
        searchStringArray.removeAll { $0 == text }
        
        searchStringArray.insert(text, at: 0)
    
        if searchStringArray.count > 5 {
            searchStringArray.removeLast()
        }
        
        UserDefaults.standard.set(searchStringArray, forKey: Keys.userSearchKey)
        tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension SearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {return}
        
        updateLastSearchArray(text)
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

// MARK: UITableViewDataSource
extension SearchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchStringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = searchStringArray[indexPath.row]
        return cell
    }
}
    
