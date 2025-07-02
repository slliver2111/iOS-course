//
//  ViewController.swift
//  Photo Gallery App
//
//  Created by Artur Bednarz on 28/06/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var arrayOfPhotos: [Photo] = Photo.createExampleArray()
    private var arrayOfDates: [Int] = []
    private var dictOfPhotos: [Int: [Photo]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dictOfPhotos = Dictionary(grouping: arrayOfPhotos, by: {Calendar.current.component(.year, from: $0.date)})
        arrayOfDates = dictOfPhotos.keys.sorted(by: >)
        
        setupCollectionView()
        print(arrayOfPhotos)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 160, height: 160)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let date = arrayOfDates[section]
        return dictOfPhotos[date]?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { fatalError("Error in dequeing photoCell")}
        
        let dateOfPhotos = arrayOfDates[indexPath.section]
        if let photo = dictOfPhotos[dateOfPhotos]?[indexPath.row] {
            cell.configure(with: photo)
            cell.toggleFavorite = { [weak self] in
                guard let self = self else {return}
                self.dictOfPhotos[dateOfPhotos]?[indexPath.row].isFavorite.toggle()
                
                UIView.performWithoutAnimation{
                    collectionView.reloadItems(at: [indexPath])
                }
                
                if let updatedPhoto = self.dictOfPhotos[dateOfPhotos]?[indexPath.row] {
                    let msg = updatedPhoto.isFavorite ?
                    "Marked \(updatedPhoto.title) as Favorite!" :
                    "Removed \(updatedPhoto.title) from Favorites."
                    
                    let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: HeaderView.identifier,
                                                                           for: indexPath)
                as? HeaderView else {fatalError("Error in dequeing headerView")}
        header.titleLabel.text = String(arrayOfDates[indexPath.section])
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let isLandscape = view.bounds.width > view.bounds.height
        let columns: CGFloat = isLandscape ? 5 : 3
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
        let spacing = flowLayout.minimumInteritemSpacing

        let totalSpacing = spacing * (columns - 1)
        let contentWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = contentWidth / columns

        return CGSize(width: itemWidth, height: itemWidth + 20)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)

            coordinator.animate(alongsideTransition: { [weak self] context in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }, completion: nil)
        }

}

