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
    
    
    var callback: ((ViewState) -> Void)?
    
    private(set) var upcomingDTO: UpcomingDTO?
    private(set) var searchDTO: UpcomingDTO?
   
    
    
}

