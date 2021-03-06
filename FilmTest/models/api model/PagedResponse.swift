//
//  PagedResponse.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

struct PagedResponse<T: Decodable>: Decodable {
    
    var currentPage: Int?
    var numberOfPages: Int?
    var totalResults: Int?
    var results: [T]?
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case numberOfPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentPage = try valueContainer.decode(Int.self, forKey: .currentPage)
        self.numberOfPages = try valueContainer.decode(Int.self, forKey: .numberOfPages)
        self.totalResults = try valueContainer.decode(Int.self, forKey: .totalResults)
        self.results = try valueContainer.decode([T].self, forKey: .results)
    }
}
