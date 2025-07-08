//
//  Untitled.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 08/07/2025.
//

import Foundation

enum APIConstants {
    static let key: String = ""
    static let baseurl: String = ""
    static let endpoint: String = ""
    
    static func buildURL() -> URL? {
        guard var components = URLComponents(string: baseurl + endpoint) else {return nil}
        
        components.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "pahe", value: "1"),
        ]
        
        return components.url
    }
}
