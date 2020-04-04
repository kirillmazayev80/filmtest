//
//  NetworkService.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 26.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire
    

protocol APIManagerProtocol: class {
    associatedtype Model
    func loadData(by query: [String: Any]?,
                  from page: Int?,
                  completion: @escaping (Result<Model>) -> Void)
}

extension APIManagerProtocol {
    
    func executeRequest<T: Decodable>(url: URL,
                        method: HTTPMethod = .get,
                        params: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil,
                        completion: @escaping (Result<T>) -> Void) {
        
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: encoding,
                   headers: headers)
            .validate()
            .responseJSON { [weak self] response in
                guard let resultResponse = self?.handleResponse(type: T.self,
                                                               from: response) else { return }
                completion(resultResponse)
        }
        
    }
    
    // handling response for proper api model
    func handleResponse<T: Decodable>(type: T.Type, from response: DataResponse<Any, AFError>) -> Result<T>  {
        guard let data = response.data else { return .error(FetchError.requestError(value: .reqNoDataErr)) }
        switch (response.result) {
            case .success:
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    return .success(model)
                } catch {
                    return .error(FetchError.parseError)
                }
            case .failure:
                if let httpStatusCode = response.response?.statusCode {
                    switch (httpStatusCode) {
                        case 400: return .error(FetchError.requestError(value: .req400Err))
                        case 401: return .error(FetchError.requestError(value: .req401Err))
                        case 404: return .error(FetchError.requestError(value: .req404Err))
                        case 500: return .error(FetchError.requestError(value: .req500Err))
                        default : return .error(FetchError.requestError(value: .reqUnknownErr))
                    }
                } else {
                    return .error(FetchError.requestError(value: .reqUnknownErr))
                }
        }
    }
    
}
