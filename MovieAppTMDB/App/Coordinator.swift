//
//  Coordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit.UINavigationController

protocol Coordinator {
    
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    
    func showController(controller: UIViewController) {
        navigationController.show(controller, sender: nil)
    }
}
