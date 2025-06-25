//
//  Untitled.swift
//  5. Gym Schedule App
//
//  Created by Artur Bednarz on 24/06/2025.

import UIKit

class GymClassCell: UITableViewCell {
    static let identifier = "MojCell"
    
    private let mainLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stackView = UIStackView(arrangedSubviews: [mainLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
