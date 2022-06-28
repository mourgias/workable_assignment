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
    
    private var cachedSearchedMovies: [MovieDataModel] = []
    private var searchedMoviesDataModel: [MovieDataModel] = []
    
    // MARK: Pagination
    
    var pagination: Pagination?
    var searchPagination: Pagination?
    
    private var isLoading: Bool = false
    
    var searchText: String?
    
    var isSearching: Bool {
        return searchText != nil
    }
    
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
    
    private func updateSearchPagination(page: Pagination) {
        self.searchPagination = Pagination.update(page)
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
}

// MARK: DataSource Methods

extension PopularMoviesViewModel {
    
    func dataModel(for index: Int) -> MovieDataModel? {
        
        if isSearching {
            guard searchedMoviesDataModel.indices.contains(index) else { return nil }
            return searchedMoviesDataModel[index]
        }
        
        guard moviesDataModel.indices.contains(index) else { return nil }
        return moviesDataModel[index]
    }
    
    func numberOfRows() -> Int {
        
        if isSearching {
            return searchedMoviesDataModel.count
        }
        
        return moviesDataModel.count
    }
    
    var isReachLastPage: Bool {
        
        if isSearching {
            return self.searchPagination?.reachLastPage ?? false
        }
        
        return self.pagination?.reachLastPage ?? false
    }
}

// MARK: Favorite Item methods

extension PopularMoviesViewModel {

    func addToFavorites(id: String) {
        
        if isSearching {
            if let movie = searchedMoviesDataModel.first(where: { $0.id == id }) {
                DataContext.addFavorite(with: movie)
            }
            return
        }
        
        if let movie = moviesDataModel.first(where: { $0.id == id }) {
            DataContext.addFavorite(with: movie)
        }
    }
    
    func removeFromFavorites(id: String) {
        DataContext.removeFavorite(with: id)
    }
}

// MARK: Searching Methods

extension PopularMoviesViewModel {
 
    // MARK: Clean Search Results
    
    private func cleanSearchedSource() {
        searchText = nil
        cachedSearchedMovies.removeAll()
        searchedMoviesDataModel.removeAll()
        reloadDataSubject.send()
    }
    
    func searchMovie(with text: String?) {
        
        self.searchText = text
        self.fetchSearchResult()
    }
    
    func fetchSearchResult(isFromScroll: Bool = false) {
        
        guard let searchText = searchText, !searchText.isEmpty else {
            // ---- clean source
            cleanSearchedSource()
            return
        }
        
        if isLoading { return }
        
        let nextPage = isFromScroll ? (searchPagination == nil ? 1 : searchPagination!.nextPage) : 1
        
        isLoading = true
        
        service.searchMovies(text: searchText, page: nextPage).done { [weak self] response in
            guard let self = self else { return }
            
            let pagination = Pagination(currentPage: response.page, nextPage: response.page, totalPages: response.totalPages)
            self.updateSearchPagination(page: pagination)
            
            self.buldSearchDataModel(response.results, cachedMovies: isFromScroll)
            
            self.isLoading = false
            
        } catchError: { error in
            print(error)
            self.isLoading = false
            
        }.store(in: &self.cancellable)
    }
    
    // MARK: Build Search Result Data Model
    
    private func buldSearchDataModel(_ response: [APIResponseSearchResult], cachedMovies: Bool) {
        
        let model = response.compactMap { item in
            
            MovieDataModel(id: item.id,
                             title: item.title,
                             voteAveragePercent: item.voteAveragePercent,
                             voteAverageValue: item.voteAverage ?? 0,
                             releaseDateFormatted: item.releaseDateFormatted,
                             posterImageUrl: item.posterImageUrl,
                             mediaType: item.mediaType)
            
        }
        
        if cachedMovies {
            self.cachedSearchedMovies.append(contentsOf: model)
        } else {
            self.cachedSearchedMovies = model
        }
        
        searchedMoviesDataModel = cachedSearchedMovies
        reloadDataSubject.send()
    }
}
