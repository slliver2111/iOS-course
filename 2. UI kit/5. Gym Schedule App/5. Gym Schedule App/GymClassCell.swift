//
//  Untitled.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 24/06/2025.

import UIKit

class GymClassCell: UITableViewCell {
    static let identifier = "MojCell"
    
    let timeLabel = UILabel()
    let nameClassLabel = UILabel()
    let trainerNameLabel = UILabel()
    let trainerImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        timeLabel.textColor = .systemTeal
        timeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        nameClassLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        //trainerImage.translatesAutoresizingMaskIntoConstraints = false
        trainerImage.contentMode = .scaleAspectFill
        trainerImage.backgroundColor = .systemGray6
        trainerImage.clipsToBounds = true
        trainerImage.layer.cornerRadius = 14
        
        let stackViewTime = UIStackView(arrangedSubviews: [timeLabel])
        stackViewTime.axis = .vertical
        stackViewTime.alignment = .center
        
        let stackViewTrainer = UIStackView(arrangedSubviews: [trainerImage, trainerNameLabel])
        stackViewTrainer.axis = .horizontal
        stackViewTrainer.alignment = .leading
        stackViewTrainer.spacing = 12
        
        let stackViewDescription = UIStackView(arrangedSubviews: [nameClassLabel, stackViewTrainer])
        stackViewDescription.axis = .vertical
        stackViewDescription.spacing = 2
        stackViewDescription.alignment = .leading
        
        let stackViewMain = UIStackView(arrangedSubviews: [stackViewTime, stackViewDescription])
        stackViewMain.axis = .horizontal
        stackViewMain.spacing = 24
        stackViewMain.alignment = .leading
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackViewMain)
        
        NSLayoutConstraint.activate([
            stackViewTime.centerYAnchor.constraint(equalTo: stackViewMain.centerYAnchor),
            
            stackViewMain.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackViewMain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackViewMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackViewMain.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            trainerImage.widthAnchor.constraint(equalToConstant: 28),
            trainerImage.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
