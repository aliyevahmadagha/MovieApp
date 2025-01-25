//
//  AppCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit.UINavigationController

final class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    fileprivate func showHome() {
        children.removeAll()
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        children.append(tabBarCoordinator)
        tabBarCoordinator.parentCoordinator = self
        tabBarCoordinator.start()
    }
    
    fileprivate func showAuth() {
        children.removeAll()
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        children.append(authCoordinator)
        authCoordinator.parentCoordinator = self
        authCoordinator.start()
    }
}
