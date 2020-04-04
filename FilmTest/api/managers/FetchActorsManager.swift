//
//  ActorsListManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class FetchActorsManager<T>: APIManagerProtocol {
    
    func loadData(by query: [String: Any]?,
                  from page: Int? = 1,
                  completion: @escaping (Result<PagedResponse<ActorApi>>) -> ()) {
        
        guard let page = page else { return }
        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY, Utils.PAGE: page]
        
        guard let fetchActorsURL = URL(string: APIHelper.ACTORS_LIST_URL)
            else { completion(.error(FetchError.malformedRequest)); return }
        
        executeRequest(url: fetchActorsURL, params: params) { (response) in
            completion(response)
        }
    }
    
}
