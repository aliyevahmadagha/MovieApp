//
//  ViewController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 14.01.25.
//

import UIKit

final class HomeController: BaseController {
    
    private let layout: HomeColletionLayout
    
    private lazy var refreshCollection: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return refresh
    }()
    
    private lazy var movieCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 48, height: 96)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.refreshControl = refreshCollection
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .green
        return indicator
    }()
    
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.layout = HomeColletionLayout()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        configureViewModel()
        configureCompositionalLayout()
    }
    
    fileprivate func configureViewModel() {
        viewModel.getTrendingRequest()
        viewModel.getMovieRequest(category: .popular)
        viewModel.getMovieRequest(category: .toprated)
        viewModel.getMovieRequest(category: .upcoming)
        viewModel.getMovieRequest(category: .nowPlaying)
        
        viewModel.callback = { [weak self] state in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.loadingView.startAnimating()
                case .loaded:
                    self.refreshCollection.endRefreshing()
                    self.loadingView.stopAnimating()
                case .success:
                    self.movieCollection.reloadData()
                case .error(let error):
                    print(error)
                }
            }
        }
    }
    
    // refresh controller function
    @objc private func reloadPage() {
        viewModel.time = .day
    }
    
    fileprivate func configureCollection() {
        movieCollection.delegate = self
        movieCollection.dataSource = self
        movieCollection.register(cell: TrendingCell.self)
        movieCollection.register(cell: TopRatedCell.self)
        movieCollection.register(cell: PopularCell.self)
        movieCollection.register(cell: UpcomingCell.self)
        movieCollection.register(cell: NowPlayingCell.self)
        movieCollection.register(cell: TrendingSegmentCell.self)
        movieCollection.register(cell: MoviesSegmentCell.self)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(movieCollection)
        view.addSubview(loadingView)
        movieCollection.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        movieCollection.fillSuperviewSafeAreaLayoutGuide()
        loadingView.fillSuperviewSafeAreaLayoutGuide()
    }
}

extension HomeController {
    
    fileprivate func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else {return nil}
            switch sectionIndex {
            case 0: return self.layout.segmentSection()
            case 1: return self.layout.trailerSection()
            case 2: return self.layout.segmentSection()
            case 3: return self.layout.trendingSection()
            case 4: return self.layout.segmentSection()
            case 5: return self.layout.trendingSection()
            case 6: return self.layout.segmentSection()
            case 7: return self.layout.trendingSection()
            case 8: return self.layout.segmentSection()
            case 9: return self.layout.trendingSection()
            default: return nil
            }
        }
        movieCollection.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TrendingSegmentCell = collectionView.dequeue(for: indexPath)
            cell.configureSegmentName(name: "Trending")
            cell.delegate = self
            return cell
        case 1:
            let cell: TrendingCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getTrendingItem(index: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(model: item)
            return cell
        case 2:
            let cell: MoviesSegmentCell = collectionView.dequeue(for: indexPath)
            cell.configureSegmentName(name: "Popular")
            return cell
        case 3:
            let cell: PopularCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getPopularItem(index: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(model: item)
            return cell
        case 4:
            let cell: MoviesSegmentCell = collectionView.dequeue(for: indexPath)
            cell.configureSegmentName(name: "Top Rated")
            return cell
        case 5:
            let cell: TopRatedCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getTopRatedItem(index: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(model: item)
            return cell
        case 6:
            let cell: MoviesSegmentCell = collectionView.dequeue(for: indexPath)
            cell.configureSegmentName(name: "Upcoming")
            return cell
        case 7:
            let cell: UpcomingCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getUpcomingItem(index: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(model: item)
            return cell
        case 8:
            let cell: MoviesSegmentCell = collectionView.dequeue(for: indexPath)
            cell.configureSegmentName(name: "Now Playing")
            return cell
        case 9:
            let cell: NowPlayingCell = collectionView.dequeue(for: indexPath)
            guard let item = viewModel.getNowPlayingItem(index: indexPath.row) else {return UICollectionViewCell()}
                cell.configureCell(model: item)
                return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: 1
        case 1: viewModel.getTrendingCount()
        case 2: 1
        case 3: viewModel.getPopularCount()
        case 4: 1
        case 5: viewModel.getTopRatedCount()
        case 6: 1
        case 7: viewModel.getUpcomingCount()
        case 8: 1
        case 9: viewModel.getNowPlayingCount()
        default:
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detectSection(indexPath: indexPath)
    }
}

extension HomeController: TrendingSegmentProtocol {
    func didClickedSegment(index: Int) {
        viewModel.time = index == 0 ? .day : .week
    }
}
