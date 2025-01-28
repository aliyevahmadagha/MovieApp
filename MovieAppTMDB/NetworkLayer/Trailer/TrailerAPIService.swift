//
//  TrailerAPIService.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

private let apiService = CoreAPIManager.instance
final class TrailerAPIService: TrailerUseCase {
  
    func getTrailerRequest(movieId movieID: String, completion: @escaping (TrailerDTO?, String?) -> Void) {
        apiService.request(
            type: TrailerDTO.self,
            url: TrailerHelper.trailer(movieID).endPoint,
            method: .GET) { [weak self] result in
                guard let _ = self else {return}
                switch result {
                case .success(let data):
                    completion(data, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
}

