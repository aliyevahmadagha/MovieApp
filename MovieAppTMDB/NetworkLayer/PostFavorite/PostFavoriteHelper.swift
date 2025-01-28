//
//  PostFavoriteHelper.swift
//  MoovieeAPP
//
//  Created by Javidan on 24.01.25.
//

import Foundation
enum PostFavoriteHelper {
    case addFav


    private var mainPath: String {
        return "account/" + accountId + "/favorite?api_key=" + token + "&session_id=" + sessionId
    }
    private var accountId: String {
        return "21750219"
    }
    private var token: String {
        "62c4714366147c656b9a51941f830e367ecb8370"
    }
    private var sessionId: String {
        "6595a47a3f5aee2ef84b8ffc865ed72fbe9b79ce"
    }
    
     var endPoint: URL? {
        switch self {
        case .addFav:
            return CoreAPIHelper.instance.makeURL(path: mainPath)
        }
    }
}


//664ac06ed409f9c443bf4e0f7873e355c41110bb
//ee4a464dbfc0477a42fb16fd05a624155039a2c5
//21698853



// MARK: my request token

// 62c4714366147c656b9a51941f830e367ecb8370 - token
// 6595a47a3f5aee2ef84b8ffc865ed72fbe9b79ce - session id
// 21750219 - account id
