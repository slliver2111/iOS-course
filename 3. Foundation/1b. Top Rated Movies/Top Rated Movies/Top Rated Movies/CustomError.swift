//
//  CustomError.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 08/07/2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is incorrect"
        case .invalidResponse:
            return "Invalid response from the server."
        case .requestFailed(let msg):
            return "There was issue with request. \(msg.localizedDescription)"
        case .decodingFailed(let msg):
            return "There was issue with decoding. \(msg.localizedDescription)"
        }
    }
    
}
