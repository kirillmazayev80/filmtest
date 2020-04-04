//
//  Result.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

// result enum for api managers
enum Result<T> {
    case success(T)
    case error(Error)
}
