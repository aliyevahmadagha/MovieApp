//
//  FavoriteViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

final class FavoriteViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case succes
        case error(String)
    }
    
    var requestCallback: ((ViewState) -> Void)?
    
    private(set) var favoriteList: FavoriteDTO?
    private let favoriteUseCase: FavoriteUseCase
    
    init() {
        favoriteUseCase = FavoriteAPIService()
    }
    
    func getFavorite() {
        requestCallback?(.loading)
        favoriteUseCase.getFavoriteMovies { result, error in
            if let data = result {
                self.requestCallback?(.loaded)
                self.favoriteList = data
                self.requestCallback?(.succes)
            } else if let error = error {
                self.requestCallback?(.error(error))
            }
        }
    }
    
    func getFavoriteItem(index: Int) -> FavoriteResult? {
        return favoriteList?.results[index]
    }
    
    func getFavoriteCount() -> Int {
        return favoriteList?.results.count ?? 0
    }
    
}

