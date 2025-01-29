//
//  AuthCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit.UINavigationController

final class AuthCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = LoginController(viewModel: .init(navigation: self))
        showController(controller: controller)
    }
}

extension AuthCoordinator: AuthNavigation {
    
    func showLogin() {
        navigationController.popViewController(animated: true)
    }
    
    func showRegister() {
        let controller = RegisterController(viewModel: .init(navigation: self))
        showController(controller: controller)
    }
}

