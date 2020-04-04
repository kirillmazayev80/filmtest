//
//  APIHelper.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 28.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

class APIHelper {
    
    // url strings for api requests
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_KEY = "22a70e0d4fabba8f679ec6f710d194fc"
    static let FETCH_MOVIES_URL = "https://api.themoviedb.org/3/discover/movie"
    static let FETCH_MOVIES_BY_GENRE_URL = "https://api.themoviedb.org/3/genre/"
    static let SEARCH_MOVIES_URL = "https://api.themoviedb.org/3/search/movie"
    static let FETCH_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
    static let OVERVIEW_URL = "https://api.themoviedb.org/3/movie/"
    static let GENRES_URL = "https://api.themoviedb.org/3/genre/movie/list"
    static let ACTORS_LIST_URL = "https://api.themoviedb.org/3/trending/person/week"
    static let BIO_URL = "https://api.themoviedb.org/3/person/"
}
