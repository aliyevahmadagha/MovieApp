//
//  MovieDetailController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 27.01.25.
//

import UIKit

final class MovieDetailController: BaseController {
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.alpha = 0.4
        return image
    }()
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var showTrailerButton: UIButton = {
        let button = UIButton()
        button.setTitle("➤ Play Trailer", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showTrailerClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var movieStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movieName, showTrailerButton, horizontalStack])
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favoriteStack, ratingStack, languageStack])
        stack.spacing = 8
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var favoriteStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favoriteImage])
        stack.spacing = 4
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart")
        image.tintColor = .red
        return image
    }()
    
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        stack.spacing = 4
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .yellow
        return image
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var languageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [languageImage, languageLabel])
        stack.spacing = 4
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var languageImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "globe")
        return image
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
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
        
        view.addSubview(showTrailerButton)
        view.addSubview(backgroundImage)
        view.addSubview(movieImage)
        view.addSubview(movieStack)
        
        backgroundImage.loadImageURL(url: viewModel.getAllDetail().icon)
        movieImage.loadImageURL(url: viewModel.getAllDetail().icon)
        movieName.text = viewModel.getAllDetail().name
        ratingLabel.text = viewModel.getAllDetail().movieRating
        languageLabel.text = viewModel.getAllDetail().movieLanguage
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        showTrailerButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            movieImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            movieImage.heightAnchor.constraint(equalToConstant: 240),
            movieImage.widthAnchor.constraint(equalToConstant: 160)
        ])

        NSLayoutConstraint.activate([
            movieStack.topAnchor.constraint(equalTo: movieImage.centerYAnchor, constant: 24),
            movieStack.leftAnchor.constraint(equalTo: movieImage.rightAnchor, constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            favoriteImage.widthAnchor.constraint(equalToConstant: 24),
            ratingImage.widthAnchor.constraint(equalToConstant: 24),
            ratingLabel.widthAnchor.constraint(equalToConstant: 36),
            languageImage.widthAnchor.constraint(equalToConstant: 24),
            languageLabel.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    @objc private func showTrailerClicked() {
        viewModel.getTrailerLink { [weak self] link in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.viewModel.watchTrailer(url: link)
            }
        }
    }
}
