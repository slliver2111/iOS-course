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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let countriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var descrStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, ratingLabel, dateLabel, countriesLabel, popularityLabel])
        sv.axis = .vertical
        sv.spacing = 2
        return sv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var photoAndInfoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, descrStackView])
        sv.axis = .horizontal
        sv.alignment = .top
        sv.spacing = 8
        return sv
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [photoAndInfoStackView, descriptionLabel])
        sv.axis = .vertical
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(mainStackView)
        
        let padding: CGFloat = 18
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    
    func configure(with movie: Movie, index: Int) {
        titleLabel.text = "\(index+1). \(movie.name)"
        ratingLabel.text = "⭐️ \(String(format: "%.1f", movie.rating))"
        dateLabel.text = "Date: \(movie.firstAirDate)"
        popularityLabel.text = "Popularity: \(String(format: "%.0f", movie.popularity))"
        descriptionLabel.text = movie.overview
        countriesLabel.text = "Countries: \(movie.originCountry.joined(separator: ", "))"
        
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
        dateLabel.text = nil
        popularityLabel.text = nil
        descriptionLabel.text = nil
        countriesLabel.text = nil
    }
}
