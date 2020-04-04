//
//  FetchGenresManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class FetchGenresManager<T>: APIManagerProtocol {
    
    func loadData(by query: [String: Any]?,
                  from page: Int?,
                  completion: @escaping (Result<GenresListApi>) -> ()) {
        
        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY]
        
        guard let genresUrl = URL(string: APIHelper.GENRES_URL)
            else { completion(.error(FetchError.malformedRequest)); return }

        executeRequest(url: genresUrl, params: params) { (response) in
            completion(response)
        }
    }
    
}
