//
//  Untitled.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 24/06/2025.

import UIKit

class GymClassCell: UITableViewCell {
    static let identifier = "MojCell"
    var toggleRegistrate: (()->Void)?
    
    var isRegistered: Bool = false {
        didSet {
            updateButtonAppearance()
            //onToggleRegistrate?()
        }
    }
    
    let timeLabel = UILabel()
    let nameClassLabel = UILabel()
    let durationClassLabel = UILabel()
    let trainerNameLabel = UILabel()
    let trainerImage = UIImageView()
    let plusButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        timeLabel.textColor = .systemTeal
        timeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        nameClassLabel.font = UIFont.boldSystemFont(ofSize: 20)
        durationClassLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setTitle(nil, for: .normal)
        plusButton.setImage(UIImage(systemName: isRegistered ? "xmark" : "plus"), for: .normal)
        plusButton.tintColor = .white
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = isRegistered ? .systemGreen : .systemTeal
        plusButton.layer.cornerRadius = 20
        plusButton.clipsToBounds = true
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        contentView.addSubview(plusButton)
        
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
        
        let stackViewClassDescription = UIStackView(arrangedSubviews: [nameClassLabel, durationClassLabel])
        stackViewClassDescription.axis = .horizontal
        stackViewClassDescription.spacing = 2
        stackViewClassDescription.alignment = .leading
        
        let stackViewDescription = UIStackView(arrangedSubviews: [stackViewClassDescription, stackViewTrainer])
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
            stackViewMain.trailingAnchor.constraint(lessThanOrEqualTo: plusButton.leadingAnchor, constant: -20),
            
            trainerImage.widthAnchor.constraint(equalToConstant: 28),
            trainerImage.heightAnchor.constraint(equalToConstant: 28),
            
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func plusTapped() {
        toggleRegistrate?()
    }
    
    private func updateButtonAppearance() {
        let imageName = isRegistered ? "xmark" : "plus"
        let backgroundColor = isRegistered ? UIColor.systemGreen : UIColor.systemTeal
        plusButton.setImage(UIImage(systemName: imageName), for: .normal)
        plusButton.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
