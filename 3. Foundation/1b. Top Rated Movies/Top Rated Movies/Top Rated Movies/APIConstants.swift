//
//  Untitled.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 08/07/2025.
//

import Foundation

enum APIConstants {
    static let key: String = "7481bbcf1fcb56bd957cfe9af78205f3"
    static let baseurl: String = "https://api.themoviedb.org/3/tv"
    static let endpoint: String = "/top_rated"
    
    static func buildURL() -> URL? {
        guard var components = URLComponents(string: baseurl + endpoint) else {return nil}
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        return components.url
    }
}
