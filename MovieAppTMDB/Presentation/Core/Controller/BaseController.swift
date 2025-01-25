//
//  BaseController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureRestriction()
    }
    
    open func configureView() {}

    open func configureRestriction() {}
}
