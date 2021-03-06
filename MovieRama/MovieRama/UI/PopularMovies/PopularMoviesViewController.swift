//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesViewController: BaseViewController {
    
    // MARK: Properties
    
    private var cancellable = Cancellable()
    
    private var viewModel = PopularMoviesViewModel()
    
    // MARK: UI Properties
    
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = true
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(MovieTableViewCell.self,
                           forCellReuseIdentifier: MovieTableViewCell.id)
        
        tableView.showRefreshControl = true
        tableView.keyboardDismissMode = .onDrag
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Detect if the child VC dismissed (pop) from navigation stack
//        if !isBeingPresented && !isMovingToParent {
//
//        }
        
        self.tableView.reloadData()
    }
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBar(title: "Popular", hasSearch: true)

        viewModel.fetchPopular()
        
        setupView()
        bindViewModel()
    }
    
    // MARK: SetupView
    
    private func setupView() {
        
        view.addSubview(tableView)
        
        tableView.layout(
            .top(navBarHeight),
            .leading(0),
            .trailing(0),
            .bottom(0)
        )
        
        tableView.addRefreshTarget(self, action: #selector(refreshContent))
    }
    
    // MARK: Bind View Model
    
    private func bindViewModel() {
        
        viewModel.reloadData.done { [weak self] in
            guard let self = self else { return }
            
            self.tableView.endRefreshingControl()
            self.tableView.hideBottomIndicator()
            self.tableView.reloadData()
        }
        .store(in: &cancellable)
        
        searchView.searchFieldValue.sink { [weak self] text in
            guard let self = self else { return }
            self.viewModel.searchMovie(with: text)
            
            // Hide refresh during searching
            self.tableView.showRefreshControl = text == nil
        }
        .store(in: &cancellable)
    }
    
    @objc
    func refreshContent() {
        self.tableView.beginRefreshingControl()
        
        // Perform some delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let self = self else { return }
            self.viewModel.refreshContent()
        }
    }
}

// MARK: UITableViewDelegate - UITableViewDataSource

extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            // print("will request new data 🔃")
            
            // check if reach the last page
            if !viewModel.isReachLastPage {
                
                if viewModel.isSearching {
                    viewModel.fetchSearchResult(isFromScroll: true)
                } else {
                    viewModel.fetchPopular(isFromScroll: true)
                }
                
                tableView.showBottomIndicator()
            } else {
                tableView.hideBottomIndicator()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = viewModel.dataModel(for: indexPath.row)
        
        guard let movie = movie,
              let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id) else {
            return UITableViewCell()
        }
        
        switch cell {
            
        case let (cell as MovieTableViewCell):
            
            cell.setContent(movie: movie)
            
            cell.favoriteButton
                .publisher(for: .touchUpInside)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    
                    cell.favoriteButton.isSelected.toggle()
                    
                    if cell.favoriteButton.isSelected {
                        self.viewModel.addToFavorites(id: movie.id)
                    } else {
                        self.viewModel.removeFromFavorites(id: movie.id)
                    }
                }
                .store(in: &cell.cancellable)
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movie = viewModel.dataModel(for: indexPath.row) else { return }
        
        let detailsViewController = MovieDetailsViewController()
        detailsViewController.viewModel.fetchMovie(with: movie.id, mediaType: movie.mediaType)
        baseNavigationController?.pushViewController(detailsViewController, animated: true)
    }
}
