//
//  LoginCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit.UINavigationController

final class LoginCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = LoginController(viewModel: .init())
        showController(controller: controller)
    }
}
