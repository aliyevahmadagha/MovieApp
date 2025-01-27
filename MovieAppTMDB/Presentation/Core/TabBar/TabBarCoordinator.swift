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
    
    private var tabBarController = TabBarController()
    private var homeCoordinator: HomeCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    func start() {
        showTabbar()
    }
    
    fileprivate func showTabbar() {
        
        // Home Controller
        let homeController = UINavigationController()
        homeController.setNavigationBarHidden(true, animated: false)
        homeCoordinator = HomeCoordinator(navigationController: homeController)
        homeCoordinator?.parentCoordinator = self
        homeCoordinator?.start()
        
        let homeTab = UITabBarItem()
        homeTab.title = "Movies"
        homeTab.image = UIImage(systemName: "movieclapper")
        homeTab.selectedImage = UIImage(systemName: "movieclapper.fill")
        homeController.tabBarItem = homeTab
        
        // Profile Controller
        let profileController = UINavigationController()
        profileController.setNavigationBarHidden(true, animated: false)
        profileCoordinator = ProfileCoordinator(navigationController: profileController)
        profileCoordinator?.parentCoordinator = self
        profileCoordinator?.start()
        
        let profileTab = UITabBarItem()
        profileTab.title = "Profile"
        profileTab.image = UIImage(systemName: "person")
        profileTab.selectedImage = UIImage(systemName: "person.fill")
        profileController.tabBarItem = profileTab
        
        tabBarController.viewControllers = [homeController, profileController]
        navigationController.pushViewController(tabBarController, animated: true)
        
        self.children.append(homeCoordinator ?? HomeCoordinator(navigationController: UINavigationController()))
        
        self.children.append(profileCoordinator ?? ProfileCoordinator(navigationController: UINavigationController()))
    }
}

