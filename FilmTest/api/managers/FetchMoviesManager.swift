//
//  FetchMoviesManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 28.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class FetchMoviesManager<T>: APIManagerProtocol {

    func loadData(by query: [String: Any]?,
                  from page: Int? = 1,
                  completion: @escaping (Result<PagedResponse<MovieApi>>) -> ()) {
        
        guard let page = page else { return }
        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY, Utils.PAGE: page]
        
        var fetchMoviesUrlStr = ""
        if (query == nil) {
            // fetch most viewed movies
            fetchMoviesUrlStr = APIHelper.FETCH_MOVIES_URL
        } else {
            // fetch movies by genre
            if let genreId = query?[Utils.GENRE_ID] {
                fetchMoviesUrlStr = "\(APIHelper.FETCH_MOVIES_BY_GENRE_URL)\(genreId)/movies"
            }
        }
        
        guard let fetchMoviesUrl = URL(string: fetchMoviesUrlStr)
            else { completion(.error(FetchError.malformedRequest)); return }
        
        executeRequest(url: fetchMoviesUrl, params: params) { (response) in
            completion(response)
        }
    }
    
}


