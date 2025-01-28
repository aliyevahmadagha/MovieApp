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
    
    private var movieId: String {
        String(movieDetail.movieId)
    }
    
    var requestCallback: ((ViewState) -> Void)?
    
    private weak var navigation: HomeNavigation?
    private let movieDetail: MovieDetail
    private let trailerUseCase: TrailerUseCase
    private(set) var trailerDTO: TrailerDTO?
    private var trailerResults: TrailerResult?
    
    
    init(
        navigation: HomeNavigation,
        movieDetail: MovieDetail
    ) {
        self.navigation = navigation
        self.movieDetail = movieDetail
        trailerUseCase = TrailerAPIService()
    }
    
    func getAllDetail() -> MovieDetail {
        movieDetail
    }
    
    func watchTrailer(url: String) {
          navigation?.showTrailer(url: url)
    }
    
    func getTrailerRequest() {
        requestCallback?(.loading)
        trailerUseCase.getTrailerRequest(movieId: movieId) { [weak self] dto, error in
            guard let self = self else { return }
            requestCallback?(.loaded)
            if let dto = dto {
                self.trailerDTO = dto
                self.trailerResults = dto.results.first
                requestCallback?(.success)
            } else if let error = error {
                requestCallback?(.error(error))
            }
        }
    }
    
    func getTrailerLink(completion: @escaping (String) -> Void) {
        getTrailerRequest()
        requestCallback = { [weak self] state in
            guard let self = self else {return}
            switch state {
            case .success:
                if let trailerPath = self.trailerResults?.trailerPath {
                    completion(trailerPath)
                } else {
                    completion("No trailer link")
                }
            case .error(_):
                completion("error request")
            default:
                break
            }
        }
    }
    
}
