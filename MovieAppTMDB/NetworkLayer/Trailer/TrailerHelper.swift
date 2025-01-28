//
//  TrailerHelper.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

enum TrailerHelper {
    case trailer(String)
    
    private var mainPath: String {
        return "movie/"
    }
    
    var endPoint: URL? {
       switch self {
       case .trailer(let movieID):
           return CoreAPIHelper.instance.makeURL(path: mainPath + movieID + "/videos")
       }
   }
}
