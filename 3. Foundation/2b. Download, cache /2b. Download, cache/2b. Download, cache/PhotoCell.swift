//
//  PhotoCell.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//

import UIKit

// MARK: UI CELL
class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray6
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with url: URL) {
        ImageCacheManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let img):
                self.imageView.image = img
            case .failure(let error):
                print("Some error occured: \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
