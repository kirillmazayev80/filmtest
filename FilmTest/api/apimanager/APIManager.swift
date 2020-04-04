//
//  APIManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 20.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Foundation

class APIManager<T>: APIManagerProtocol {
    
    typealias Completion = (Result<T>) -> Void
    
    fileprivate let loadingClosure: (_ query: [String: Any]?, _ page: Int?, @escaping Completion) -> Void
    
    init<L: APIManagerProtocol>(loader: L) where L.Model == T {
        loadingClosure = loader.loadData
    }
        
    func loadData(by query: [String: Any]? = nil,
                  from page: Int? = 1,
                  completion: @escaping Completion) {
        loadingClosure(query, page, completion)
    }

}
