//
//  Movie.swift
//  Top Rated Movies
//
//  Created by Artur Bednarz on 07/07/2025.
//



struct APIResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let rating: Double
    let firstAirDate: String
    let originCountry: [String]
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case popularity = "popularity"
    }
}
