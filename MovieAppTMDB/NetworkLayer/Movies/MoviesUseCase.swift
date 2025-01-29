//
//  MoviesUseCase.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

protocol MoviesUseCase {
    
    func getPopular(completion: @escaping(PopularDTO?, String?) -> Void?)
    func getUpcoming(completion: @escaping(UpcomingDTO?, String?) -> Void)
    func getTopRated(completion: @escaping(TopRatedDTO?, String?) -> Void?)
    func getNowPlaying(completion: @escaping(NowPlayingDTO?, String?) -> Void?)
    
    
}
