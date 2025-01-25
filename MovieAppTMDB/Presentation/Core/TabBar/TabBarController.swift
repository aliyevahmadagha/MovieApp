//
//  TabBarController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    fileprivate func setUpTabs() {
        
        self.tabBar.backgroundColor = .white
        let homeTab = UITabBarItem()
        homeTab.title = "Movies"
        homeTab.image = UIImage(systemName: "movieclapper")
        
        let homeVC = HomeController(viewModel: HomeViewModel())
        let navHomeVC = UINavigationController(rootViewController: homeVC)
        navHomeVC.tabBarItem = homeTab
        navHomeVC.tabBarItem.selectedImage = UIImage(systemName: "movieclapper.fill")
        
        let profileTab = UITabBarItem()
        profileTab.title = "Profile"
        profileTab.image = UIImage(systemName: "person")
        
        let profileVC = ProfileController(viewModel: .init())
        let navprofileVC = UINavigationController(rootViewController: profileVC)
        navprofileVC.tabBarItem = profileTab
        navprofileVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")

        setViewControllers([navHomeVC, navprofileVC], animated: true)
        
    }
}
