//
//  ViewController.swift
//  Photo Gallery App
//
//  Created by Artur Bednarz on 28/06/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView! //Todo
    private var arrayOfPhotos: [Photo] = Photo.createExampleArray()
    private var arrayOfDates: [Int] = []
    private var dictOfPhotos: [Int: [Photo]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        dictOfPhotos = Dictionary(grouping: arrayOfPhotos, by: {Calendar.current.component(.year, from: $0.date)})
        arrayOfDates = dictOfPhotos.keys.sorted(by: >)
        
        setupCollectionView()
        print(arrayOfPhotos)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemCyan
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        cell.backgroundColor = .green
        let dateOfPhotos = arrayOfDates[indexPath.section]
        let img = dictOfPhotos[dateOfPhotos]?[indexPath.row].image
        cell.imageView.image = img
        
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
}

