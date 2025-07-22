//
//  ImageCacheManager.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//

import UIKit

enum ImageCacheError: Error {
    case networkError(Error)
    case invalidData
    case fileReadError
    case invalidURL
}

// MARK: Image cache
class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let fileManager = FileManager.default
    private let accessKey = "KVi4qjaPT_lGAgvFiG-VnmoJaw7amRTzcKXU-xvCBZU" //for learning purpose key located here
    private let baseURL = "https://api.unsplash.com/"
    private let cacheDirName = "Images"
    private lazy var cacheDirectory: URL = {
        let tempDir = FileManager.default.temporaryDirectory
        let imgDir = tempDir.appendingPathComponent(cacheDirName)
        
        if !FileManager.default.fileExists(atPath: imgDir.path) { //create dir if doesn't exist
            do {
                try FileManager.default.createDirectory(at: imgDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error.localizedDescription)")
                return tempDir
            }
        }
        return imgDir
    }()
    
    // Monitor for memory warnings
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearCache),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func fetchAllImagesURL(completion: @escaping (Result<[URL], ImageCacheError>) -> Void) {
        // First check if there are already images cached
        do {
            let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
            if !contents.isEmpty {
                completion(.success(contents))
            }
        } catch {
            print("Failed to clear cache: \(error.localizedDescription)")
        }
        
        // Otherwise get list of photos from server
        guard var components = URLComponents(string: "\(baseURL)photos") else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
        ]
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                do {
                    let photosURL = try JSONDecoder().decode([Photo].self, from: data).map { $0.urls.regular }
                    completion(.success(photosURL))
                } catch {
                    completion(.failure(.invalidData))
                    return
                }
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, ImageCacheError>) -> Void) {
        let fileName = url.lastPathComponent
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        // Check if file already exists in cache
        if fileManager.fileExists(atPath: fileURL.path) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: fileURL),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.fileReadError))
                    }
                }
            }
            return
        }
        
        // Otherwise fetch from server
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            // Cache the image and complete with success
            self.save(image: data, for: fileName)
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
    
    func save(image: Data, for fileName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        do {
            try image.write(to: fileURL, options: .atomic)
        } catch let error {
            print("Failed to save image: ", error)
        }
        
    }
    
    @objc public func clearCache() {
        do {
            let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
            contents.forEach { file in
                try? fileManager.removeItem(at: file)
            }
        } catch {
            print("Failed to clear cache: \(error.localizedDescription)")
        }
    }
}
