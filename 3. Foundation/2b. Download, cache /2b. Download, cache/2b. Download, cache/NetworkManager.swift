//
//  NetworkManager.swift
//  2b. Download, cache
//
//  Created by Artur Bednarz on 18/07/2025.
//

import UIKit

// MARK: Network
class NetworkManager {
    private let accessKey = "KVi4qjaPT_lGAgvFiG-VnmoJaw7amRTzcKXU-xvCBZU" //for learning purpose located here
    private let baseURL = "https://api.unsplash.com/"
    
    func fetchAllImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard var components = URLComponents(string: "\(baseURL)photos") else {return}
        components.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
        ]
        
        guard let url = components.url else {
            let error = NSError(domain: "Network Manager Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Network Manager Error", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
                return
            }
        }.resume()
    }
}
