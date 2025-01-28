//
//  FavoriteController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class FavoriteController: BaseController {
    
    private let layout: HomeColletionLayout
    
    private lazy var favoriteCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 48, height: 96)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var refreshController: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return r
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.tintColor = .green
        return indicator
    }()
    
    private let viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        self.layout = HomeColletionLayout()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getFavorite()
        configureCollection()
        configureViewModel()
        configureCompositionalLayout()
    }
    
    fileprivate func configureCollection() {
        favoriteCollection.delegate = self
        favoriteCollection.dataSource = self
        favoriteCollection.register(cell: FavoriteCell.self)
        favoriteCollection.register(cell: FavoriteSectionCell.self)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(favoriteCollection)
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        favoriteCollection.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteCollection.fillSuperviewSafeAreaLayoutGuide()
    }
    
    fileprivate func configureViewModel() {
        viewModel.requestCallback = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    self.refreshController.endRefreshing()
                    case .succes:
                    self.favoriteCollection.reloadData()
                    case .error(let message):
                    print(message)
                }
            }
        }
    }
    
    @objc func reloadPage(){
        viewModel.getFavorite()
    }
}

extension FavoriteController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel.getFavoriteCount()
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: FavoriteSectionCell = collectionView.dequeue(for: indexPath)
            return cell
        case 1:
            let cell: FavoriteCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getFavoriteItem(index: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(model: item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension FavoriteController {
    
    fileprivate func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else {return nil}
            switch sectionIndex {
            case 0: return self.layout.segmentSection()
            case 1: return self.layout.trendingSection()
            default: return nil
            }
        }
        favoriteCollection.setCollectionViewLayout(layout, animated: true)
    }
}
