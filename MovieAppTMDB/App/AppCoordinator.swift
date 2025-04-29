//
//  AppCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

var defaults = UserDefaults.standard

import UIKit.UINavigationController

final class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    var window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.window = window
        self.navigationController = navigationController
        rootNotification()
    }
    
    private var isLogin: Bool = false
    
    private func rootNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchRooter), name: NSNotification.Name("switchRoot"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("switchRoot"), object: nil)
    }
    
    func start() {
        isLogin = defaults.bool(forKey: "isLogin")
        if isLogin {
            showHome()
        } else {
            showHome()
        }
    }
    
    fileprivate func showHome() {
        children.removeAll()
        navigationController.viewControllers = []
        let tabBarCoordinator = TabBarCoordinator(window: window, navigationController: navigationController)
        children.append(tabBarCoordinator)
        tabBarCoordinator.parentCoordinator = self
        tabBarCoordinator.start()
    }
    
    fileprivate func showAuth() {
        children.removeAll()
        navigationController.viewControllers = []
        let authCoordinator = AuthCoordinator(navigationController: navigationController, window: window)
        children.append(authCoordinator)
        authCoordinator.parentCoordinator = self
        authCoordinator.start()
    }
    
    @objc private func switchRooter() {
        DispatchQueue.main.async {
            self.showHome()
        }
    }
}
