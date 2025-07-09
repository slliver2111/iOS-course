//
//  NetworkManager.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 08/07/2025.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func downloadData() async throws -> [Movie] {
        guard let url = APIConstants.buildURL() else {
            throw APIError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        
        return apiResponse.results
    }
}
