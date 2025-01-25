//
//  HomeViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

final class HomeViewModel {
    
    enum viewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    enum TimeInterval: String {
        case day, week
    }
    
    enum MovieCategory {
        case popular, upcoming, toprated, nowPlaying
    }
    
    var time: TimeInterval = .day {
        didSet {
            getTrendingRequest()
        }
    }
    
    var callback: ((viewState) -> Void)?
    
    private var trendingUsaCase: TrendingUseCase
    private var movieListsUseCase: MoviesUseCase
    
    private(set) var trendingList: TrendingDTO?
    private(set) var popularList: PopularDTO?
    private(set) var upcomingList: UpcomingDTO?
    private(set) var topRatedList: TopRatedDTO?
    private(set) var nowPlayingList: NowPlayingDTO?
    
    init() {
        trendingUsaCase = TrendingAPIService()
        movieListsUseCase = MoviesAPIService()
    }
    
    func getTrendingRequest() {
        
        callback?(.loading)
        trendingUsaCase.getTrendingMovie(timeInterval: time.rawValue) { [weak self] dto, error in
            guard let self = self else {return}
            callback?(.loaded)
            guard let dto = dto else {
                guard let error = error else {return}
                callback?(.error(error))
                return
            }
            trendingList = dto
            callback?(.success)
        }
    }
    
    func getMovieRequest(category: MovieCategory) {
        
        switch category {
        case .popular:
            callback?(.loading)
            movieListsUseCase.getPopular() { [weak self] dto, error in
                guard let self = self else {return}
                callback?(.loaded)
                guard let dto = dto else {
                    guard let error = error else {return}
                    callback?(.error(error))
                    return
                }
                popularList = dto
                callback?(.success)
            }
        case .upcoming:
            callback?(.loading)
            movieListsUseCase.getUpcoming() { [weak self] dto, error in
                guard let self = self else {return}
                callback?(.loaded)
                guard let dto = dto else {
                    guard let error = error else {return}
                    callback?(.error(error))
                    return
                }
                upcomingList = dto
                callback?(.success)
            }
        case .toprated:
            callback?(.loading)
            movieListsUseCase.getTopRated { [weak self] dto, error in
                guard let self = self else {return}
                callback?(.loaded)
                
                guard let dto = dto else {
                    guard let error = error else {return}
                    callback?(.error(error))
                    return
                }
                topRatedList = dto
                callback?(.success)
            }
        case .nowPlaying:
            callback?(.loading)
            movieListsUseCase.getNowPlaying { [weak self] dto, error in
                guard let self = self else {return}
                callback?(.loaded)
                
                guard let dto = dto else {
                    guard let error = error else {return}
                    callback?(.error(error))
                    return
                }
                nowPlayingList = dto
                callback?(.success)
            }
        }
    }
    
    func getTrendingCount() -> Int {
        trendingList?.results?.count ?? 0
    }
    
    func getTrendingItem(index: Int) -> TrendingResult? {
        trendingList?.results?[index]
    }
    
    func getPopularCount() -> Int {
        popularList?.results?.count ?? 0
    }
    
    func getPopularItem(index: Int) -> PopularResult? {
        popularList?.results?[index]
    }
    
    func getUpcomingCount() -> Int {
        upcomingList?.results?.count ?? 0
    }
    
    func getUpcomingItem(index: Int) -> UpcomingResult? {
        upcomingList?.results?[index]
    }
    
    func getTopRatedCount() -> Int {
        topRatedList?.results?.count ?? 0
    }
    
    func getTopRatedItem(index: Int) -> TopRatedResult? {
        topRatedList?.results?[index]
    }
    
    func getNowPlayingCount() -> Int {
        nowPlayingList?.results?.count ?? 0
    }
    
    func getNowPlayingItem(index: Int) -> NowPlayingResult? {
        nowPlayingList?.results?[index]
    }
}
