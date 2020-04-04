//
//  FetchError.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

// fetch error for api request result
enum FetchError: Error {
    case requestError(value: RequestError)
    case parseError
    case malformedRequest
}
