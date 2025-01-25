//
//  CoreAPIHelper.swift
//  URLSession
//
//  Created by Aslanli Faqan on 22.11.24.
//

import Foundation

enum HttpMethods: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}

enum BaseURL: String {
    case prodV3 = "https://api.themoviedb.org/3/"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    
    private let baseURL = BaseURL.prodV3.rawValue
    
    func makeURL(path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
    
    func makeHeader() -> [String: String] {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTE4ZWFmMTcyMjBkNTczZjZiMzZjMmZhM2MzMjQ2YiIsIm5iZiI6MTczNjg0MjYzMC41MTAwMDAyLCJzdWIiOiI2Nzg2MWQ4NmM1ZDJlOTZlMjY3YmQyNGEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.XENTLSOvKPzURK09vFD6VqtVwnbb3kxnWW4kp70rvJo"
        ]
    }
}
