//
//  ImageCacheManager.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 12/07/2025.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let accessKey = "KVi4qjaPT_lGAgvFiG-VnmoJaw7amRTzcKXU-xvCBZU" //normally should be hidden
    private let baseURL = "https://api.unsplash.com/"
    
    func fetchAllImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard var components = URLComponents(string: "\(baseURL)photos") else {return}
        components.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
        ]
        
        guard let url = components.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let photos = try
                JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                return
            }
        }.resume()
    }
}
