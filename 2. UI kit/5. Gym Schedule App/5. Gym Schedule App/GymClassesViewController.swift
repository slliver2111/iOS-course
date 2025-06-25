//
//  ViewController.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit

class GymClassesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(frame: .zero)
    private let arrayOfGymClass = GymClass.loadExampleData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfGymClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gymclass = arrayOfGymClass[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier)!
        cell.textLabel?.text = gymclass.name
            
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GymClasses"
        view.backgroundColor = .systemBackground
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.identifier)
        tableView.frame = view.bounds
        tableView.reloadData()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}
