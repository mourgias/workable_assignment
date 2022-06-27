//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

//protocol PopularMoviesViewModelProtocol {
//
//    var reloadData: AnyPublisher<Void, Never> { get }
//    var isReachLastPage: Bool { get }
//
//    func fetchPopular(isFromRefresh: Bool, isFromScroll: Bool)
//
//    func dataModel(for index: Int) -> MovieDataModel?
//    func numberOfRows() -> Int
//    func refreshContent()
//}

class PopularMoviesViewModel {
    
    private var cancellable = Cancellable()
    
    // MARK: Service
    
    private var service: PopularMoviesServiceProtocol!
    
    // MARK: ModieDataModel Source
    
    private var cachedMovies: [MovieDataModel] = []
    private var moviesDataModel: [MovieDataModel] = []
    
    // MARK: Pagination
    
    var pagination: Pagination?
    private var isLoading: Bool = false
    
    // MARK: Reload data Publisher
    
    var reloadData: AnyPublisher<Void, Never> {
        return reloadDataSubject.eraseToAnyPublisher()
    }
    
    private var reloadDataSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Init
    
    init(service: PopularMoviesServiceProtocol = PopularMoviesService()) {
        self.service = service
    }
    
    deinit {
        print("♻️ PopularMoviesViewModel")
    }
    
    func fetchPopular(isFromRefresh: Bool = false, isFromScroll: Bool = false) {
        
        if isLoading { return }
        let nextPage = isFromScroll ? (pagination == nil ? 1 : pagination!.nextPage) : 1
        //print("next page: \(nextPage)")
        isLoading = true
        
        service.fetchPopular(nextPage: nextPage).done { [weak self] response in
            guard let self = self else { return }
            print(response.toPrintedJSON)
            
            let pagination = Pagination(currentPage: response.page, nextPage: response.page, totalPages: response.totalPages)
            self.updatePagination(page: pagination)
            
            if isFromRefresh {
                self.cachedMovies.removeAll()
            }
            
            self.buldDataModel(response.popularMovies)
            
            self.isLoading = false
            
        } catchError: { error in
            print(error)
            self.isLoading = false
            
        }.store(in: &cancellable)
    }
    
    // MARK: Update Pagination
    
    private func updatePagination(page: Pagination) {
        self.pagination = Pagination.update(page)
        print(pagination!)
    }
    
    // MARK: Refresh Content
    
    func refreshContent() {
        pagination = nil
        fetchPopular(isFromRefresh: true)
    }
    
    // MARK: Build Movies Data Model
    
    private func buldDataModel(_ response: [APIResponsePopularMovie]) {
        
        let model = response.compactMap { item -> MovieDataModel in
            
            return MovieDataModel(id: item.id,
                                  title: item.title,
                                  voteAveragePercent: item.voteAveragePercent,
                                  voteAverageValue: item.voteAverage,
                                  releaseDateFormatted: item.releaseDateFormatted,
                                  posterImageUrl: item.posterImageUrl)
        }
        
        cachedMovies.append(contentsOf: model)
        moviesDataModel = cachedMovies
        reloadDataSubject.send()
    }
    
    func addToFavorites(id: String) {
        if let movie = moviesDataModel.first(where: { $0.id == id }) {
            DataContext.addFavorite(with: movie)
        }
    }
    
    func removeFromFavorites(id: String) {
        DataContext.removeFavorite(with: id)
    }
}

// MARK: DataSource Methods

extension PopularMoviesViewModel {
    
    func dataModel(for index: Int) -> MovieDataModel? {
        guard moviesDataModel.indices.contains(index) else { return nil }
        return moviesDataModel[index]
    }
    
    func numberOfRows() -> Int {
        return moviesDataModel.count
    }
    
    var isReachLastPage: Bool {
        return self.pagination?.reachLastPage ?? false
    }
}
