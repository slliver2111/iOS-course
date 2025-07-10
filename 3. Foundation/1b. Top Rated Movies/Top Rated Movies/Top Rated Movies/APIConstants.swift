//
//  Untitled.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 08/07/2025.
//

import Foundation

enum APIConstants {
    static var APIkey: String {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
            fatalError("Cant find Keys.plist")
        }
        let plist = NSDictionary(contentsOfFile:filePath)
        guard let value = plist?.object(forKey: "TheMovieDBAPIKey") as? String else {
            fatalError("Cant find a key: TheMovieDBAPIKey in Keys.plist")
        }
        return value
    }
    static let baseurl: String = "https://api.themoviedb.org/3/tv"
    static let endpoint: String = "/top_rated"
    
    static func buildURL() -> URL? {
        guard var components = URLComponents(string: baseurl + endpoint) else {return nil}
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIkey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        return components.url
    }
}
