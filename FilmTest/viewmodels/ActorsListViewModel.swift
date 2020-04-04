//
//  ActorsViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class ActorsListViewModel: Messagable {
    
    fileprivate let apiManager: APIManager<PagedResponse<ActorApi>>?
    
    let actors = MutableObservableArray<Actor>([])
    var errorMessages = PassthroughSubject<String, Never>()
    
    let hasEndRefreshing = Observable<Bool>(false)
    let isLoadingNextPage = Observable<Bool>(false)
    
    fileprivate var currentPage = 1
    fileprivate var shouldShowLoadingNextPage = false
    
    // MARK - Initializer
    init<T: APIManagerProtocol>(loader: T)
        where T.Model == PagedResponse<ActorApi> {
            self.apiManager = APIManager(loader: loader)
            self.bindIsLoadingNextPage()
            refreshMovies()
    }
    
    // MARK - Bindings
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
    
    // MARK - Fetching
    fileprivate func fetchNextPage() {
        currentPage += 1
        loadMovies()
    }
    
    func refreshMovies() {
        currentPage = 1
        loadMovies(refresh: true)
    }
    
    fileprivate func loadMovies(refresh: Bool = false) {
        guard let apiManager = apiManager else { return }
        
        apiManager.loadData(from: currentPage)
        { [unowned self] (result) in
            switch (result) {
                case .success(let page):
                    guard let fetchedApiActors = page.results,
                        let currentPage = page.currentPage,
                        let numberOfPages = page.numberOfPages
                        else { return }
                
                    let fetchedActors: [Actor] = fetchedApiActors.map{ $0.convert() }
                    if refresh {
                        self.actors.removeAll()
                        self.actors.insert(contentsOf: fetchedActors, at: 0)
                    } else {
                        fetchedActors.forEach({ (actor) in
                            if (!self.actors.array.contains(actor)) {
                                self.actors.append(actor)
                            }
                        })
                    }
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
    
}
