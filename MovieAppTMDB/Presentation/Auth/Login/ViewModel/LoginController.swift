//
//  LoginController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 22.01.25.
//

import UIKit

final class LoginController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
