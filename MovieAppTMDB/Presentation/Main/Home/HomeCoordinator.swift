//
//  HomeCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import UIKit.UINavigationController

final class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeController(viewModel: .init())
        showController(controller: controller)
    }
}
