//
//  SettingsViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 16.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class SelectGenreSettingsViewModel: Messagable {
    
    fileprivate var apiManager: APIManager<GenresListApi>?
    
    let genres = MutableObservableArray<Genre>([])
    var errorMessages = PassthroughSubject<String, Never>()
    let genreHasChanged = Observable<Bool>(false)
    
    init<T: APIManagerProtocol>(loader: T) where T.Model == GenresListApi {
        self.apiManager = APIManager(loader: loader)
        self.fetchGenres()
    }
    
    func fetchGenres() {
        if let apiManager = apiManager {
            apiManager.loadData()
            { [unowned self] result in
                switch result {
                    case .success(let genresApiList):
                        guard let genresApi = genresApiList.genresApi else { return }
                        let genres = genresApi.compactMap { $0.convert() }
                        self.genres.removeAll()
                        self.genres.insert(contentsOf: genres, at: 0)
                    case .error (let error):
                        self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                              name: String(describing: self),
                                              error: error)
                }
            }
        }
    }
    
    func storeGenre(_ genre: Genre) {
        UserDefaults.standard.set(genre.id, forKey: Utils.GENRE_ID)
        UserDefaults.standard.set(genre.name, forKey: Utils.GENRE_NAME)
    }
    
}
