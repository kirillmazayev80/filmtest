//
//  MoviesViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 20.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class FetchViewModel: Messagable  {
    
    fileprivate var apiManager: APIManager<PagedResponse<MovieApi>>?
    
    let movies = MutableObservableArray<Movie>([])
    var errorMessages = PassthroughSubject<String, Never>()
    let hasEndRefreshing = Observable<Bool>(false)
    let isLoadingNextPage = Observable<Bool>(false)
    let fetchingMoviesType = Observable<Int>(0)
    
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    
    // MARK - Initializer
    init<T: APIManagerProtocol>(loader: T)
        where T.Model == PagedResponse<MovieApi> {
            self.apiManager = APIManager(loader: loader)
            self.bindFetchingMoviesType()
            self.bindIsLoadingNextPage()
    }
    
    // MARK - Bindings
    fileprivate func bindFetchingMoviesType() {
        _ = fetchingMoviesType
            .removeDuplicates()
            .observe{ [unowned self] (type) in
                self.refreshMovies()
            }
    }
    
    fileprivate func bindIsLoadingNextPage() {
        _ = isLoadingNextPage
            .debounce(for: 0.3)
            .removeDuplicates()
            .observe(with: { [unowned self] (value) in
                guard let value = value.element else { return }
                guard self.shouldShowLoadingNextPage else { return }
                if value  {
                    self.fetchNextPage()
                }
            })
    }
    
    fileprivate func loadMovies(refresh: Bool = false) {
        let genreId = UserDefaults.standard.integer(forKey: Utils.GENRE_ID)
        switch (fetchingMoviesType.value) {
            case 0: loadMovies(refresh: refresh, genreId: nil)
            case 1: loadMovies(refresh: refresh, genreId: [Utils.GENRE_ID: genreId])
            default: break
        }
    }
    
    // MARK - Fetching
    fileprivate func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
   func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    fileprivate func loadMovies(refresh: Bool, genreId: [String: Int]?) {
        guard let apiManager = apiManager else { return }
        
        apiManager.loadData(by: genreId, from: currentPage)
        { [unowned self] (result) in
            
            switch (result) {
                case .success(let page):
                    guard let fetchedApiMovies = page.results,
                        let currentPage = page.currentPage,
                        let numberOfPages = page.numberOfPages
                        else { return }
                
                    let fetchedMovies: [Movie] = fetchedApiMovies.map{ $0.convert() }
                    if refresh {
                        self.movies.removeAll()
                        self.movies.insert(contentsOf: fetchedMovies, at: 0)
                    } else {
                        fetchedMovies.forEach({ (movie) in
                            if (!self.movies.array.contains(movie)) {
                                self.movies.append(movie)
                            }
                        })
                    }
                    self.isLoadingNextPage.value = false
                    self.hasEndRefreshing.value = true
                    self.shouldShowLoadingNextPage = currentPage < numberOfPages
                
                case .error(let error):
                    self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                          name: String(describing: self),
                                          error: error)
            }
        }
    }

}
