//
//  Movie.swift
//  StatefulMovieDatabase
//
//  Created by Colton Brenneman on 6/22/23.
//

import Foundation

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    let currentPage: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case movieName = "title"
        case movieRating = "vote_average"
        case movieDescription = "overview"
        case posterPath = "poster_path"
    }
    let movieName: String
    let movieRating: Double
    let movieDescription: String
    let posterPath: String?
}
