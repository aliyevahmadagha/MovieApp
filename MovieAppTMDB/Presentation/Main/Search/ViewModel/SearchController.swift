//
//  SearchController.swift
//  MovieAppTMDB
//
//  Created by Khalida Aliyeva on 28.01.25.
//

import Foundation
import UIKit

final class SearchController: BaseController {

    private lazy var refreshController: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        r.tintColor = .purple
        return r
    }()
    
    private lazy var searchBar: ReusableTextField = {
        let t = ReusableTextField(placeholder: "Search", placeholderColor: .purple.withAlphaComponent(0.7), borderColor: .purple, texttColor: .purple, bgColor: .white.withAlphaComponent(0.7))
        t.layer.borderWidth = 2
        t.delegate = self
        return t
    }()
    
    private lazy var movieTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        table.estimatedRowHeight = 100
        table.refreshControl = refreshController
        return table
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .purple
        return view
    }()

    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.getUpcomingMovies()
    }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [searchBar, movieTable, loadingView])
    }
    
    fileprivate func configureViewModel() {
        viewModel.callback = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.loadingView.startAnimating()
                case .loaded:
                    self.loadingView.stopAnimating()
                    self.refreshController.endRefreshing()
                case .success:
                    self.movieTable.reloadData()
                case .error(let message):
                    self.showMessage(message: message)
                }
            }
        }
    }
    
    @objc private func reloadPage() {
        viewModel.searchList = nil
        viewModel.getUpcomingMovies()
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        loadingView.fillSuperview()
        searchBar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, leading: 24, trailing: -24)
        )
        searchBar.anchorSize(CGSize(width: 0, height: 48))
        
      
        movieTable.anchor(
            top: searchBar.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 12, leading: 24, bottom: -8, trailing: -24)
        )
    }

}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchList?.count ?? viewModel.getUpcomingCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        guard let item = (viewModel.searchList?[indexPath.row] ?? viewModel.getUpcomingMovie(index: indexPath.row)) else {
            return UITableViewCell()
        }
        cell.configureCell(model: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height/5
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        viewModel.search(text: text)
        print(text)
    }
}
    




