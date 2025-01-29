//
//  SearchViewModel.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation

final class SearchViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    private(set) var upcomingDTO: UpcomingDTO?
    private(set) var searchDTO: UpcomingDTO?
    private(set) var upcomingResultList: UpcomingResultList?
    var searchList: UpcomingResultList?
    
    private let searchUseCase: MoviesUseCase
    
    var callback: ((ViewState) -> Void)?
    
    init() {
        searchUseCase = MoviesAPIService()
    }
    
    func getUpcomingMovies() {
        callback?(.loading)
        searchUseCase.getUpcoming { [weak self] dto, error in
            guard let self else { return }
            callback?(.loaded)
            if let dto = dto {
                self.upcomingDTO = dto
                self.searchDTO = dto
                callback?(.success)
            } else if let error = error {
                callback?(.error(error))
            }
        }
    }

    
    func getUpcomingMovie(index: Int) -> UpcomingResult? {
        searchDTO?.results?[index]
    }
    func getUpcomingCount() -> Int? {
        searchDTO?.results?.count
    }
    
    func search(text: String) {
        guard let upcomingResults = upcomingDTO?.results else {
            searchList = nil
            callback?(.error("No data available"))
            return
        }

        if text.isEmpty {
            searchList = upcomingResults
        } else {
            searchList = upcomingResults.filter { result in
                result.title?.lowercased().contains(text.lowercased()) ?? false
            }
        }

        callback?(.success)
    }
}
