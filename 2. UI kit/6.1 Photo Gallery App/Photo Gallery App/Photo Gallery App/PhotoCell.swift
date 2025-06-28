//
//  SwiftUIView.swift
//  Photo Gallery App
//
//  Created by Artur Bednarz on 28/06/2025.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier = "Photo Cell"
    
    var toggleFavorite: (()->Void)?
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray
        
        favButton.addTarget(self, action: #selector(handleHeartTap), for: .touchUpInside)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            favButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

        ])
    }
    
    @objc private func handleHeartTap() {
        toggleFavorite?()
    }
    
    func configure(with photo: Photo) {
        self.imageView.image = photo.image
        self.titleLabel.text = photo.title
        let img: String = photo.isFavorite ? "heart.fill" : "heart"
        self.favButton.setImage(UIImage(systemName: img), for: .normal)
        self.favButton.tintColor = photo.isFavorite ? .systemPink : .systemCyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
