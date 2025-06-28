//
//  ViewController.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 21/06/2025.
//

import UIKit
import Foundation

class GymClassesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView(frame: .zero)
    private let arrayOfGymClass = GymClass.loadExampleData()
    private var dictOfGymClass: [Date:[GymClass]] = [:]
    private var sortedDays: [Date] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = sortedDays[section]
        return dictOfGymClass[day]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = sortedDays[indexPath.section]
        let gymClass = dictOfGymClass[day]![indexPath.row] //TODO
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier) as? GymClassCell else {
            return UITableViewCell()
        }
        cell.nameClassLabel.text = gymClass.name
        cell.durationClassLabel.text = "(\(gymClass.duration) min)"
        cell.trainerNameLabel.text = gymClass.trainer.name
        cell.trainerImage.image = gymClass.trainer.photo
        
        if let hour = gymClass.time.hour, let minute = gymClass.time.minute {
            cell.timeLabel.text = String(format: "%02d:%02d", hour, minute)
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE dd/MM/yyyy"
        return formatter.string(from: sortedDays[section])//sortedDays[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedDays.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GymClasses"
        
        // Prepare data
        dictOfGymClass = Dictionary(grouping: arrayOfGymClass, by: { $0.day })
        sortedDays = dictOfGymClass.keys.sorted()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.identifier)
        tableView.frame = view.bounds
        //tableView.backgroundColor = .systemGray
        tableView.reloadData()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}
