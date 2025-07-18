//
//  Photo.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//


import UIKit


// MARK: - --- Networking ---
class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.unsplash.com/"
    
    // --- IMPORTANT ---
    // Replace this with your own Unsplash Access Key.
    // Get one for free from https://unsplash.com/developers
    private let accessKey = "YOUR_ACCESS_KEY_HERE"

    private init() {}

    /// Fetches a list of photos from the Unsplash API.
    /// - Parameters:
    ///   - page: The page number to fetch.
    ///   - completion: A closure to be executed when the fetch is complete.
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        guard accessKey != "YOUR_ACCESS_KEY_HERE" else {
            let error = NSError(domain: "NetworkManagerError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Please replace 'YOUR_ACCESS_KEY_HERE' with your Unsplash Access Key."])
            completion(.failure(error))
            return
        }
        
        var components = URLComponents(string: "\(baseURL)photos")!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "21"), // Fetch 21 for a nice 3-column grid
            URLQueryItem(name: "client_id", value: accessKey)
        ]
        
        guard let url = components.url else {
            let error = NSError(domain: "NetworkManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NetworkManagerError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


// MARK: - --- Caching ---
class ImageCache {
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    
    private lazy var mainDirectoryUrl: URL = {
        let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
        let cacheDirectory = temporaryDirectory.appendingPathComponent("ImageCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error)")
                return temporaryDirectory
            }
        }
        
        return cacheDirectory
    }()

    func getFileUrl(for key: String) -> URL? {
        let fileURL = mainDirectoryUrl.appendingPathComponent(key)
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }
        return fileURL
    }
    
    func set(_ image: UIImage, for key: String) {
        if let jpegData = image.jpegData(compressionQuality: 0.5) {
           let fileURL = mainDirectoryUrl.appendingPathComponent(key)
           do {
               try jpegData.write(to: fileURL, options: .atomic)
           } catch let error {
               print("Failed to save image:", error)
           }
        }
    }
    
    func clearCache() {
        do {
            let contents = try fileManager.contentsOfDirectory(at: mainDirectoryUrl, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try fileManager.removeItem(at: fileUrl)
            }
            print("Cache cleared successfully.")
        } catch {
            print("Could not clear cache directory: \(error)")
        }
    }
}

// MARK: - --- UI Components ---
extension UIImageView {
    func downloadImage(from url: URL) {
        let cacheKey = url.lastPathComponent
        
        if let cachedImageURL = ImageCache.shared.getFileUrl(for: cacheKey),
           let image = UIImage(contentsOfFile: cachedImageURL.path) {
            self.image = image
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
                }
            
            ImageCache.shared.set(image, for: cacheKey)

            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

class ImageCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with url: URL) {
        imageView.downloadImage(from: url)
    }
}


// MARK: - --- Main ViewController ---
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var photos: [Photo] = []
    private var currentPage = 1
    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Unsplash Photos"
        setupCollectionView()
        setupClearCacheButton()
        setupActivityIndicator()
        fetchInitialPhotos()
    }
    
    private func fetchInitialPhotos() {
        activityIndicator.startAnimating()
        fetchPhotos(page: currentPage)
    }

    private func fetchPhotos(page: Int) {
        guard !isLoading else { return }
        isLoading = true
        
        NetworkManager.shared.fetchPhotos(page: page) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.isLoading = false
                
                switch result {
                case .success(let newPhotos):
                    self.photos.append(contentsOf: newPhotos)
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func setupClearCacheButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear Cache", style: .plain, target: self, action: #selector(handleClearCache))
    }

    @objc private func handleClearCache() {
        ImageCache.shared.clearCache()
        self.photos = []
        self.currentPage = 1
        self.collectionView.reloadData()
        fetchInitialPhotos()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        let photo = photos[indexPath.item]
        cell.configure(with: photo.urls.regular)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    // This delegate method is used to detect when the user scrolls to the bottom.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Trigger fetch for the next page if the user is near the end of the current list.
        if indexPath.item == photos.count - 6 && !isLoading {
            currentPage += 1
            fetchPhotos(page: currentPage)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 4) / 3 // 3 cells per row with 2 points of spacing
        return CGSize(width: width, height: width)
    }
}
