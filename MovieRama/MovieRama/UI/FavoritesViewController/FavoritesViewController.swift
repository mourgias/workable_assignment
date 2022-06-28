//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    // MARK: Properties
    
    private var cancellable = Cancellable()
    
    private var viewModel = FavoritesViewModel()
    
    // MARK: UI Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = true
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(MovieTableViewCell.self,
                           forCellReuseIdentifier: MovieTableViewCell.id)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBar(title: "Favorites")

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
    }
    
    // MARK: Bind View Model
    
    private func bindViewModel() {
        
        viewModel.reloadData.done { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        .store(in: &cancellable)
    }
}

// MARK: UITableViewDelegate - UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.numberOfRows() == 0 {
            tableView.setEmptyDataSourceMessage("You don't have any favorites yet")
        } else {
            tableView.removeEmptyDataSourceMessage()
        }
        
        return viewModel.numberOfRows()
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
                        self.viewModel.removeFromFavorites(at: indexPath.row)
                        
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                        
                        // May be need another workaround
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.tableView.reloadData()
                        }
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
