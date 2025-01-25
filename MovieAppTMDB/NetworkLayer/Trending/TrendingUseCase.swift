//
//  TrendingUseCase.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

protocol TrendingUseCase {
    
    func getTrendingMovie(timeInterval: String, completion: @escaping(TrendingDTO?, String?) -> Void?)
}
