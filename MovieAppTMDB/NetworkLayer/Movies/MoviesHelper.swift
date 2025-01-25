//
//  MoviesHelper.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import Foundation

enum MoviesHelper {
    
    case popular
    case nowPlaying
    case topRated
    case upComing
    
    var mainPath: String {
        return "movie/"
    }
    
    var endpoint: URL? {
        switch self {
        case .popular:
            return CoreAPIHelper.instance.makeURL(path: mainPath + "popular")

        case .nowPlaying:
            return CoreAPIHelper.instance.makeURL(path: mainPath + "now_playing")

        case .topRated:
            return CoreAPIHelper.instance.makeURL(path: mainPath + "top_rated")

        case .upComing:
            return CoreAPIHelper.instance.makeURL(path: mainPath + "upcoming")
        }
    }
}
