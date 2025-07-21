//
//  ViewController.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 11/07/2025.
//

//MARK: Main View Controller
import UIKit

class MainViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var photos: [Photo] = []
    private var networkManager: NetworkManager
    private var imageCacheManager: ImageCacheManager
    
    init(networkManager: NetworkManager = NetworkManager(), imageCacheManager: ImageCacheManager = ImageCacheManager()) {
        self.networkManager = networkManager
        self.imageCacheManager = imageCacheManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Photo cache app"
        setupUI()
        fetchAllImages()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearCacheTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchAllImages))
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let itemSize = (view.frame.size.width - 24) / 2
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        view.addSubview(collectionView)
    }
    
    
    @objc private func fetchAllImages() {
        self.photos = []
        networkManager.fetchAllImages { [weak self] result in
            
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let newPhotos):
                    self.photos.append(contentsOf: newPhotos)
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc private func clearCacheTapped() {
        ImageCacheManager.shared.clearCache()
        self.photos = []
        self.collectionView.reloadData()
        showAlert(title: "Info", message: "Cache cleared")
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        cell.configure(with: photo.urls.regular)
        return cell
    }
}
