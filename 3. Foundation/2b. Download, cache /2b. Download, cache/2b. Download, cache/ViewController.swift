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
    private var photosURL: [URL] = []
    private var imageCacheManager: ImageCacheManager
    
    init(imageCacheManager: ImageCacheManager = ImageCacheManager()) {
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
        fetchAllImagesURL()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(clearCacheTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        
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
    
    @objc private func refreshTapped() {
        ImageCacheManager.shared.clearCache()
        self.photosURL = []
        fetchAllImagesURL()
    }
    
    @objc private func clearCacheTapped() {
        ImageCacheManager.shared.clearCache()
        self.photosURL = []
        collectionView.reloadData()
        showAlert(title: "Info", message: "Cache cleared")
    }
    
    private func fetchAllImagesURL() {
        ImageCacheManager.shared.fetchAllImagesURL { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let photosURL):
                    self.photosURL.append(contentsOf: photosURL)
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: photosURL[indexPath.row])
        return cell
    }
}
