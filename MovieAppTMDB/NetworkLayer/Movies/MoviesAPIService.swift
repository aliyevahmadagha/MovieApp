//
//  MoviesAPIService.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

final class MoviesAPIService: MoviesUseCase {
    
    private let apiService = CoreAPIManager.instance
    
    func getUpcoming(completion: @escaping (UpcomingDTO?, String?) -> Void?) {
        apiService.request(
            type: UpcomingDTO.self,
            url: MoviesHelper.upComing.endpoint,
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
    
    func getTopRated(completion: @escaping (TopRatedDTO?, String?) -> Void?) {
        apiService.request(
            type: TopRatedDTO.self,
            url: MoviesHelper.topRated.endpoint,
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
    
    func getNowPlaying(completion: @escaping (NowPlayingDTO?, String?) -> Void?) {
        apiService.request(
            type: NowPlayingDTO.self,
            url: MoviesHelper.nowPlaying.endpoint,
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
    
    func getPopular(completion: @escaping (PopularDTO?, String?) -> Void?) {
        apiService.request(
            type: PopularDTO.self,
            url: MoviesHelper.popular.endpoint,
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
