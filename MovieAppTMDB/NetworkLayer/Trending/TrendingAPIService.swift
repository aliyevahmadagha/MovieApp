//
//  TrendingAPIService.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

final class TrendingAPIService: TrendingUseCase {
    private let apiService = CoreAPIManager.instance
    
    func getTrendingMovie(timeInterval: String, completion: @escaping (TrendingDTO?, String?) -> Void?) {
        apiService.request(
            type: TrendingDTO.self,
            url: TrendingHelper.all(timeInterval).endpoint,
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
