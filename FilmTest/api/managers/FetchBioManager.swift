//
//  BioManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class FetchBioManager<T>: APIManagerProtocol {
    
    func loadData(by query: [String: Any]?,
                  from page: Int? = 1,
                  completion: @escaping (Result<BioApi>) -> ()) {
        
        let params: Parameters = [Utils.API_KEY: APIHelper.API_KEY]

        guard let actorsId = query?[Utils.ID],
            let bioUrl = URL(string: "\(APIHelper.BIO_URL)\(actorsId)")
            else { completion(.error(FetchError.malformedRequest)); return }
        
        executeRequest(url: bioUrl, params: params) { (response) in
            completion(response)
        }
    }
    
}
