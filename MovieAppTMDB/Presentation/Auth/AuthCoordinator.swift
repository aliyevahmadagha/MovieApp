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
        showLogin()
    }
    
    fileprivate func showLogin() {
        children.removeAll()
        let coordinator = LoginCoordinator(navigationController: navigationController)
        children.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
}

