//
//  TabBarCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import UIKit.UINavigationController

final class TabBarCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTabbar()
    }
    
    fileprivate func showTabbar() {
        
        let controller = TabBarController()
        showController(controller: controller)
        
    }
}

