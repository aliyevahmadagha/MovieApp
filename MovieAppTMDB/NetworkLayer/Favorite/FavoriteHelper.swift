//
//  FavoriteHelper.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

enum FavoriteHelper {
    case favorite

    private var mainPath: String {
        return "account/" + accountID + "/favorite/movies"
    }
    private var accountID: String {
        return "21698853"
    }
    
     var endPoint: URL? {
        switch self {
        case .favorite:
            return CoreAPIHelper.instance.makeURL(path: mainPath)
        }
    }
    
   
}
