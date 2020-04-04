//
//  RequestError.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

// request errors by http status codes
enum RequestError {
    case reqNoDataErr
    case req400Err
    case req401Err
    case req404Err
    case req500Err
    case reqUnknownErr
}
