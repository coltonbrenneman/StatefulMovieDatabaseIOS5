//
//  MovieDetail.swift
//  StatefulMovieDatabase
//
//  Created by Colton Brenneman on 6/23/23.
//

import Foundation

struct MovieDetailDict: Decodable {
    
    let budget: Int
    let revenue: Int
    let title: String
    let popularity: Double
    let runtime: Int
    let tagline: String
    let overview: String
}

