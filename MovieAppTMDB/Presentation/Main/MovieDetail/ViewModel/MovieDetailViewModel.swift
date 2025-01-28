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
        case addFavorite(String)
        case deleteFavorite(String)
        case error(String)
    }
    
    private var movieId: String {
        String(movieDetail.movieId)
    }
    
    private var intMovieId: Int {
        guard let intMovieId = Int(movieDetail.movieId) else {return 0}
        return intMovieId
    }
    
    var requestCallback: ((ViewState) -> Void)?
    
    private weak var navigation: HomeNavigation?
    private let movieDetail: MovieDetail
    private let trailerUseCase: TrailerUseCase
    private(set) var trailerDTO: TrailerDTO?
    
    private var trailerResults: TrailerResult?
    private let postFavoriteUseCase: PostFavoriteUseCase
    
    
    init(
        navigation: HomeNavigation,
        movieDetail: MovieDetail
    ) {
        self.navigation = navigation
        self.movieDetail = movieDetail
        trailerUseCase = TrailerAPIService()
        postFavoriteUseCase = PostFavoriteAPIService()
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
    
    func addFavorite() {
        let body: [String: Any] = [
            "media_id": intMovieId,
            "media_type": "movie",
            "favorite": true
        ]
        postFavoriteUseCase.postFavorite(body: body) { [weak self] dto, error in
            guard let self = self else { return }
            requestCallback?(.loaded)
            if let _ = dto {
                requestCallback?(.success)
                print("success")
                postFavoriteNotification()
                requestCallback?(.addFavorite("added favorite"))
            } else if let error = error {
                requestCallback?(.error(error))
                postFavoriteNotification()
            }
        }
    }
    
    func removeFavorite() {
        let body: [String: Any] = [
            "media_id": intMovieId,
            "media_type": "movie",
            "favorite": false
        ]
        postFavoriteUseCase.postFavorite(body: body) { [weak self] dto, error in
            guard let self = self else { return }
            requestCallback?(.loaded)
            if let _ = dto {
                requestCallback?(.success)
                postFavoriteNotification()
                requestCallback?(.addFavorite("added favorite"))
            } else if let error = error {
                requestCallback?(.error(error))
                postFavoriteNotification()
            }
        }
    }
    
    func postFavoriteNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("FavoriteCollectionReload"), object: nil)
    }
}
