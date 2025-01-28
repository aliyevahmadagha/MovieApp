//
//  TrailerDTO.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

protocol TrailerProtocol {
    var trailerPath: String {get}
}

// MARK: - TrailerDTO
struct TrailerDTO: Codable {
    let id: Int
    let results: [TrailerResult]
}

// MARK: - Result
struct TrailerResult: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

var trailerMainPath = "https://www.youtube.com/watch?v="

extension TrailerResult: TrailerProtocol {
    var trailerPath: String {
        trailerMainPath + key
    }
}
