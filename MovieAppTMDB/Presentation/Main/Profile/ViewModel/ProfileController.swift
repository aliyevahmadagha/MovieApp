//
//  ProfileController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 23.01.25.
//

import UIKit

final class ProfileController: BaseController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
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

