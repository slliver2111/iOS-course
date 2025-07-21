//
//  ImageCacheManager.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//

import UIKit

// MARK: Image cache
class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let fileManager = FileManager.default
    private lazy var cacheDirectory: URL = {
        let tempDir = FileManager.default.temporaryDirectory
        let cacheDir = tempDir.appendingPathComponent("Images2")
        
        if !FileManager.default.fileExists(atPath: cacheDir.path) {
            do {
                try FileManager.default.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating cache directory: \(error.localizedDescription)")
                return tempDir
            }
        }
        return cacheDir
    }()
    
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
    
    @objc public func clearCache() {
        do {
            
            let contents = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
            print(contents)
            contents.forEach { file in
                try? fileManager.removeItem(at: file)
            }
            print("Cache cleared.")
            let after = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: [])
            print("After clearing:", after)
        } catch {
            print("Failed to clear cache: \(error.localizedDescription)")
        }
    }
    
    func getFileUrl(for key: String) -> URL? {
        let safeKey = makeSafeFilename(key)
        let fileURL = cacheDirectory.appendingPathComponent(safeKey)
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }
        return fileURL
    }
    
    func save(image: UIImage, for key: String) {
        if let jpegData = image.jpegData(compressionQuality: 0.5) {
            let safeKey = makeSafeFilename(key)
            let fileURL = cacheDirectory.appendingPathComponent(safeKey )
            do {
                try jpegData.write(to: fileURL, options: .atomic)
            } catch let error {
                print("Failed to save image:", error)
            }
        }
    }

    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let rawKey = url.absoluteString
        let safeKey = makeSafeFilename(rawKey)

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            }
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            self.save(image: image, for: safeKey)

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }

    
    func makeSafeFilename(_ key: String) -> String {
        return key.replacingOccurrences(of: "[^a-zA-Z0-9_]", with: "_", options: .regularExpression)
    }
}
