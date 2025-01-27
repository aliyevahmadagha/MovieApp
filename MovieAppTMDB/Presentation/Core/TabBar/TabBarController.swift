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
        configureTabBar()
    }
    
    fileprivate func configureTabBar() {
        
        self.tabBar.backgroundColor = .purple
        self.tabBar.barTintColor = .purple
    }
}
