//
//  ProfileCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 23.01.25.
//

import UIKit.UINavigationController

final class ProfileCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = ProfileController(viewModel: .init())
        showController(controller: controller)
    }
}
