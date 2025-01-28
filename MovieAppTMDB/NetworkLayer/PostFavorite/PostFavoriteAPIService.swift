//
//  PostFavoriteAPIService.swift
//  MoovieeAPP
//
//  Created by Javidan on 24.01.25.
//

import Foundation

private let apiService = CoreAPIManager.instance
final class PostFavoriteAPIService: PostFavoriteUseCase {
  
    func postFavorite(body:[String : Any], completion: @escaping (PostFavoriteDTO?, String?) -> Void) {
        apiService.request(
            type: PostFavoriteDTO.self,
            url: PostFavoriteHelper.addFav.endPoint,
            method: .POST, body: body) { [weak self] result in
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
