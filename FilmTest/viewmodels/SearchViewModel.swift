//
//  SearchViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 27.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class SearchViewModel: Messagable {

    fileprivate let apiManager: APIManager<PagedResponse<MovieApi>>?
    
    let movies = MutableObservableArray<Movie>([])
    var errorMessages = PassthroughSubject<String, Never>()
    let searchString = Observable<String>("")
    let isLoadingNextPage = Observable<Bool>(false)
    let hasEndRefreshing = Observable<Bool>(false)
    
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    // MARK - Initializer
    init<T: APIManagerProtocol>(loader: T)
        where T.Model == PagedResponse<MovieApi> {
            self.apiManager = APIManager(loader: loader)
            self.bindSearchString()
            self.bindIsLoadingNextPage()
    }
    
    // MARK - Bindings
    fileprivate func bindSearchString() {
        _ = searchString
            .filter { $0.count > 3 }
            .throttle(for: 0.5)
            .observeNext { [unowned self] text in
                guard text != "" else { return }
                self.clearResultsTable()
                self.searchMovies(by: text)
        }
    }
    
    fileprivate func bindIsLoadingNextPage() {
        _ = isLoadingNextPage
            .debounce(for: 0.3)
            .removeDuplicates()
            .observe(with: { (value) in
                guard let value = value.element else { return }
                guard self.shouldShowLoadingNextPage else { return }
                if value  {
                    self.fetchNextPage()
                }
            })
    }
    
    // MARK - Fetching
    fileprivate func fetchNextPage() {
        currentPage += 1
        searchMovies(by: searchString.value)
    }
    
    func refreshMovies() {
        currentPage = 1
        searchMovies(by: searchString.value)
    }
    
    fileprivate func searchMovies(by text: String) {
        guard let apiManager = apiManager else { return }

        apiManager.loadData(by: [Utils.QUERY: text], from: currentPage)
        { [unowned self] (result) in
            switch (result) {
                case .success (let page):
                    guard let fetchedApiMovies = page.results,
                        let currentPage = page.currentPage,
                        let numberOfPages = page.numberOfPages
                        else { return }
                    fetchedApiMovies.forEach({ (movieApi) in
                        let movie = movieApi.convert()
                        if (!self.movies.array.contains(movie)) {
                            self.movies.append(movie)
                        }
                    })
                    self.isLoadingNextPage.value = false
                    self.hasEndRefreshing.value = true
                    self.shouldShowLoadingNextPage = currentPage < numberOfPages
                
                case .error (let error):
                    self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                          name: String(describing: self),
                                          error: error)
            }
        }
    }
    
    func clearResultsTable() {
        currentPage = 1
        shouldShowLoadingNextPage = false
        movies.removeAll()
    }
    
}
