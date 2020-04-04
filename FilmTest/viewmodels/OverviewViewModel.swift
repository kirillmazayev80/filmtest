//
//  OverviewMovieViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class OverviewViewModel: Messagable {
    
    fileprivate let apiManager: APIManager<OverviewApi>?
    fileprivate let dbManager: DBManager?
    let movie: Movie?
    
    let overview = Observable<Overview?>(nil)
    var errorMessages = PassthroughSubject<String, Never>()
    let hasAdded = Observable<Bool>(false)
    typealias Model = OverviewApi
    
    init<T: APIManagerProtocol>(loader: T, movie: Movie)
        where T.Model == OverviewApi {
            self.apiManager = APIManager(loader: loader)
            self.dbManager = DBManager()
            self.movie = movie
            self.hasAdded.value = dbManager?.hasAdded(by: movie.id) ?? false
            self.fetchOverview(by: String(movie.id))
    }
    
    func fetchOverview(by id: String) {
        if let apiManager = self.apiManager {
            apiManager.loadData(by: [Utils.ID: id])
            { [unowned self] result in
                switch result {
                    case .success(let overview):
                        self.overview.value = overview.convert()
                    case .error (let error):
                        self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                              name: String(describing: self),
                                              error: error)
                }
            }
        }
    }
    
    func isAdded() {
        guard let dbManager = self.dbManager, let id = movie?.id else { return }
        self.hasAdded.value = dbManager.hasAdded(by: id) 
    }
    
    func onAddMovie() {
        guard let dbManager = self.dbManager,
            var movie = self.movie else { return }
        movie.overview = overview.value
        dbManager.create(movie: movie)
    }
    
    func onRemoveMovie() {
        guard let dbManager = dbManager,
            let movie = self.movie else { return }
        dbManager.delete(primaryKey: movie.id)
    }
    
}
