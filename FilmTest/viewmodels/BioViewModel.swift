//
//  BioViewModel.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit

class BioViewModel: Messagable {
    
    fileprivate let apiManager: APIManager<BioApi>?
    
    let bio = Observable<Bio?>(nil)
    var errorMessages = PassthroughSubject<String, Never>()
    
    
    init<T: APIManagerProtocol>(loader: T, actorId: String)
        where T.Model == BioApi {
            self.apiManager = APIManager(loader: loader)
            self.fetchBio(by: actorId)
    }
    
    func fetchBio(by id: String) {
        if let apiManager = self.apiManager {
            apiManager.loadData(by: [Utils.ID: id])
            { [unowned self] result in
                switch result {
                    case .success (let bioApi):
                        self.bio.value = bioApi.convert()
                    case .error (let error):
                        self.sendErrorMessage(text: Strings.TRY_AGAIN_ERR_TXT,
                                              name: String(describing: self),
                                              error: error)
                }
            }
        }
    }
    
}
