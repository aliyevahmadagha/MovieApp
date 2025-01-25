//
//  TrendingHelper.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

import Foundation

enum TrendingHelper {
    case all(String)
    
    var mainPath: String {
        return "trending/"
    }
    
    var endpoint: URL? {
        switch self {
        case .all(let query):
            return CoreAPIHelper.instance.makeURL(path: "\(mainPath)all/\(query)")
        }
    }
}
