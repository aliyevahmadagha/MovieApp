//
//  TopRatedDTO.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import Foundation

// MARK: - TopRatedDTO
struct TopRatedDTO: Codable {
    let page: Int?
    let results: [TopRatedResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TopRatedResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    private var imageBasePath = "https://image.tmdb.org/t/p/w500"
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension TopRatedResult: CellProtocol {
    var movieName: String {
        title ?? originalTitle ?? "empty"
    }
    
    var movieDate: String {
        releaseDate ?? "empty"
    }
    
    var iconURL: String {
        imageBasePath + (posterPath ?? "")
    }
}

extension TopRatedResult {
    
    func mapToDomain() -> MovieDetail  {
        .init(icon: iconURL, name: movieName, date: movieDate, movieId: "\(id ?? 0)", movieLanguage: originalLanguage ?? "empty", movieRating: "\(voteAverage ?? 0.0)")
    }
}
