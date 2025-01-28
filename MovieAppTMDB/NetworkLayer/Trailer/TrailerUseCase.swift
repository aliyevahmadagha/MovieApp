//
//  TrailerUseCase.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

protocol TrailerUseCase {
    func getTrailerRequest(movieId: String, completion: @escaping (TrailerDTO?, String?) -> Void)
}
