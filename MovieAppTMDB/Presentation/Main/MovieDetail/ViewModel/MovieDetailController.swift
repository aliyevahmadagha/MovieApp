//
//  MovieDetailController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 27.01.25.
//

import UIKit

final class MovieDetailController: BaseController {
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var movieName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var detailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieImage, movieName])
        stack.axis = .horizontal
        return stack
    }()
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(movieImage)
        
        movieImage.loadImageURL(url: viewModel.getAllDetail().icon)
        movieName.text = viewModel.getAllDetail().title
                                
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        
        movieImage.fillSuperviewSafeAreaLayoutGuide()
    }
}
