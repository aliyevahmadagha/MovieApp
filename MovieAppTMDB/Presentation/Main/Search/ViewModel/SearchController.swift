//
//  SearchController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class SearchController: BaseController {

    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
