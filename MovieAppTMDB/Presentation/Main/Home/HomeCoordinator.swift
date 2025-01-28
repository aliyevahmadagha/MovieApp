//
//  HomeCoordinator.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 19.01.25.
//

import UIKit.UINavigationController

final class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeController(viewModel: .init(navigation: self))
        showController(controller: controller)
    }
}

extension HomeCoordinator: HomeNavigation {
    func showTrailer(url: String) {
        let controller = WebViewController(url: url)
        navigationController.show(controller, sender: nil)
    }
    
    func showDetail(detail: MovieDetail) {
        let controller = MovieDetailController(viewModel: .init(navigation: self, movieDetail: detail))
        controller.hidesBottomBarWhenPushed = true
        showController(controller: controller)
    }
}
