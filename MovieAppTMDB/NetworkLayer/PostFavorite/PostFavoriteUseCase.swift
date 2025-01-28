//
//  PostFavoriteUseCase.swift
//  MoovieeAPP
//
//  Created by Javidan on 24.01.25.
//

import Foundation
protocol PostFavoriteUseCase {
    func postFavorite(body: [String: Any], completion: @escaping(PostFavoriteDTO?, String?) -> Void)
}
