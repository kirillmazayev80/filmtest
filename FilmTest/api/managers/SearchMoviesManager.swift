//
//  FindMoviesManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 28.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class SearchMoviesManager<T>: APIManagerProtocol {
    
    func loadData(by query: [String: Any]?,
                  from page: Int? = 1,
                  completion: @escaping (Result<PagedResponse<MovieApi>>) -> ()) {
        
        guard let query = query?[Utils.QUERY], let page = page else { return }
        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY, Utils.QUERY: query, Utils.PAGE: page]
        
        guard let searchMoviesURL = URL(string: APIHelper.SEARCH_MOVIES_URL)
            else { completion(.error(FetchError.malformedRequest)); return }

        executeRequest(url: searchMoviesURL, params: params) { (response) in
            completion(response)
        }
    }
    
}
