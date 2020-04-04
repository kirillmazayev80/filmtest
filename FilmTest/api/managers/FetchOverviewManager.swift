//
//  OverviewManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class FetchOverviewManager<T>: APIManagerProtocol {

    func loadData(by query: [String: Any]?,
                  from page: Int?,
                  completion: @escaping (Result<OverviewApi>) -> ()) {

        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY]
        
        guard let overviewId = query?[Utils.ID],
            let overviewUrl = URL(string: "\(APIHelper.OVERVIEW_URL)\(overviewId)")
            else { completion(.error(FetchError.malformedRequest)); return }

        executeRequest(url: overviewUrl, params: params) { (response) in
            completion(response)
        }
    }
    
}
