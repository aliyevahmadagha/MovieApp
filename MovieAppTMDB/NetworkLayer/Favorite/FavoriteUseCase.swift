//
//  FavoriteUseCase.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

protocol FavoriteUseCase {
    func getFavoriteMovies(completion: @escaping(FavoriteDTO?, String?) -> Void)
}
