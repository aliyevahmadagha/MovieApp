//
//  TrendingDTO.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import Foundation

// MARK: - TrendingDTO
struct TrendingDTO: Codable {
    let page: Int?
    let results: [TrendingResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TrendingResult
struct TrendingResult: Codable {
    let backdropPath: String?
    let id: Int?
    let title, originalTitle, overview, posterPath: String?
    let mediaType: String?
    let adult: Bool?
    let originalLanguage: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
    private var imageBasePath = "https://image.tmdb.org/t/p/w500"

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

extension TrendingResult: CellProtocol {
    var movieName: String {
        name ?? originalName ?? title ?? originalTitle ?? "empty"
    }
    
    var movieDate: String {
        releaseDate ?? "empty"
    }
    
    var iconURL: String {
        imageBasePath + (posterPath ?? "")
    }
}

// MARK: Movie Detail

extension TrendingResult {
    
    func mapToDomain() -> MovieDetail  {
        .init(icon: iconURL, name: movieName, date: movieDate, movieId: "\(id ?? 0)", movieLanguage: originalLanguage ?? "empty", movieRating: "\(voteAverage ?? 0.0)")
    }
}
