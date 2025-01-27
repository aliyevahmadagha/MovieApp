//
//  MovieDetailViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 27.01.25.
//

import Foundation

final class MovieDetailViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    private weak var navigation: HomeNavigation?
    var requestCallback: ((ViewState) -> Void)?
    
    private let movieDetail: MovieDetail
    
    init(
        navigation: HomeNavigation,
        movieDetail: MovieDetail
    ) {
        self.navigation = navigation
        self.movieDetail = movieDetail
//        print(movieDetail)
    }
    
    func getAllDetail() -> MovieDetail {
        movieDetail
    }

    
}
