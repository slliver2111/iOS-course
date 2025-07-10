//
//  ViewController.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 07/07/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    private var movies: [Movie] = []
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        cv.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top Movies by themoviedb.org"
        view.backgroundColor = .systemBackground
        
        setupLayout()
        startFetching()
    }
    
    private func startFetching() {
        Task {
            do {
                self.movies = try await NetworkManager.shared.downloadData()
            } catch let error as APIError {
                showAlert(data: error)
            } catch let error as DecodingError {
                showAlert(data: .decodingFailed(error))
            } catch {
                showAlert(data: .requestFailed(error))
            }
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showAlert(data: APIError) {
        let alert = UIAlertController(title: "Alert", message: data.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ :UICollectionView, numberOfItemsInSection: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie, index: indexPath.row)
        return cell
    }
}
