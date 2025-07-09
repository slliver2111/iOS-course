//
//  MovieCell.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 07/07/2025.
//

import UIKit

// MARK: - Custom CollectionView Cell
class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    private var imgURL: URL?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        imageView.addSubview(ratingLabel)

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            ratingLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with movie: Movie, index: Int) {
        titleLabel.text = "\(index+1). \(movie.name)"
        ratingLabel.text = "⭐️ \(String(format: "%.1f", movie.rating))"
        
        if let path = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(path)"
            if let url = URL(string: urlString) {
                self.imgURL = url
                URLSession.shared.dataTask(with: url) {[weak self] data,_,_ in
                    if let data = data, let image = UIImage(data: data) {
                        guard self?.imgURL == url else {return}
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
    }
}
