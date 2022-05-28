//
//  Movie.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 28/05/2022.
//

import Foundation
struct TrendingMovies:Codable {
    let results: [Movie]
}
struct Movie:Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int
}
