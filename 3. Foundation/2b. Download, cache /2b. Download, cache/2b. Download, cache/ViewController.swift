//
//  ViewController.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 11/07/2025.
//

//MARK: Main View Controller
import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private lazy var collectionView = {
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        return cv
    }()
    
    private var photos: [Int] = [1,2,3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Photo cache app"
        view.addSubview(collectionView)
        ImageCacheManager.shared.fetchAllPhotos()
    }
}


extension MainViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        //let photo = photos[indexPath.row]
        //cell.configure(with: photo.urls.regular)
        return cell
    }
}
