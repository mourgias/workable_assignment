//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesViewController: BaseViewController {
    
    // MARK: Properties
    
    private var cancellable = Cancellable()
    
    var viewModel = PopularMoviesViewModel()
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBar(title: "Popular")

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
            self.tableView.reloadData()
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
                self.viewModel.fetchPopular(isFromScroll: true)
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
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movie = viewModel.dataModel(for: indexPath.row) else { return }
        
        let detailsViewController = MovieDetailsViewController()
        baseNavigationController?.pushViewController(detailsViewController, animated: true)
    }
}
