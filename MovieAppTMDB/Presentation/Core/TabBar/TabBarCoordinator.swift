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
    private let window: UIWindow
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    private var tabBarController = TabBarController()
    private var homeCoordinator: HomeCoordinator?
    private var favoriteCoordinator: FavoriteCoordinator?
    private var searchCoordinator: SearchCoordinator?
    
    func start() {
        showTabbar()
    }
    
    fileprivate func showTabbar() {
        
        navigationController.isNavigationBarHidden = true
        
        // Home Controller
        let homeController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: homeController)
        homeCoordinator?.parentCoordinator = self
        homeCoordinator?.start()
        
        let homeTab = UITabBarItem()
        homeTab.title = "Movies"
        homeTab.image = UIImage(systemName: "movieclapper")
        homeTab.selectedImage = UIImage(systemName: "movieclapper.fill")
        homeController.tabBarItem = homeTab
        
        // Favorite Controller
        let favoriteController = UINavigationController()
        favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteController)
        favoriteCoordinator?.parentCoordinator = self
        favoriteCoordinator?.start()
        
        let favoriteTab = UITabBarItem()
        favoriteTab.title = "Favorite"
        favoriteTab.image = UIImage(systemName: "heart")
        favoriteTab.selectedImage = UIImage(systemName: "heart.fill")
        favoriteController.tabBarItem = favoriteTab
        
        // Search Controller
        let searchController = UINavigationController()
        searchCoordinator = SearchCoordinator(navigationController: searchController)
        searchCoordinator?.parentCoordinator = self
        searchCoordinator?.start()
        
        let searchTab = UITabBarItem()
        searchTab.title = "Search"
        searchTab.image = UIImage(systemName: "magnifyingglass.circle")
        searchTab.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        searchController.tabBarItem = searchTab
        
        tabBarController.viewControllers = [homeController, favoriteController, searchController]
        
        navigationController.setViewControllers([tabBarController], animated: true)
        
        
        self.children.append(homeCoordinator ?? HomeCoordinator(navigationController: UINavigationController()))
        self.children.append(favoriteCoordinator ?? FavoriteCoordinator(navigationController: UINavigationController()))
        self.children.append(searchCoordinator ?? SearchCoordinator(navigationController: UINavigationController()))
    }
}

