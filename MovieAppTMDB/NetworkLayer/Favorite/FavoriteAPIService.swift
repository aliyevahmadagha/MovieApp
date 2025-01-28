//
//  FavoriteAPIService.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

private let apiService = CoreAPIManager.instance
final class FavoriteAPIService: FavoriteUseCase {
    
    func getFavoriteMovies(completion: @escaping (FavoriteDTO?, String?) -> Void) {
        apiService.request(
            type: FavoriteDTO.self,
            url: FavoriteHelper.favorite.endPoint,
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
