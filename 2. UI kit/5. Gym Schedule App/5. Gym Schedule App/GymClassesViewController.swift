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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier) as? GymClassCell else {
            return UITableViewCell()
        }
        
        let day = sortedDays[indexPath.section]
        if let gymClass = dictOfGymClass[day]?[indexPath.row] {
            cell.nameClassLabel.text = gymClass.name
            cell.durationClassLabel.text = "(\(gymClass.duration) min)"
            cell.trainerNameLabel.text = gymClass.trainer.name
            cell.trainerImage.image = gymClass.trainer.photo
            cell.isRegistered = gymClass.isRegistered
        }
        
        cell.toggleRegistrate = { [weak self, weak cell] in
            guard let self = self,
                  let strongCell = cell,
                  let indexPath = self.tableView.indexPath(for: strongCell)
            else {
                return
            }
            
            let day = self.sortedDays[indexPath.section]
            
            guard var classFromDict = self.dictOfGymClass[day]?[indexPath.row] else { return }
            classFromDict.isRegistered.toggle()
            self.dictOfGymClass[day]?[indexPath.row] = classFromDict
            
            if let updatedCell = self.tableView.cellForRow(at: indexPath) as? GymClassCell {
                updatedCell.isRegistered = classFromDict.isRegistered
            }
            
            let message = classFromDict.isRegistered ?
            "You have registered to \(classFromDict.name),\nsee you there!" :
            "You have just cancelled \(classFromDict.name) :("
            let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            
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
