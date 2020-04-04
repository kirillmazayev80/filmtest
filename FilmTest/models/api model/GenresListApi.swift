//
//  GenresList.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

struct GenresListApi: Decodable {
    
    let genresApi: [GenreApi]?
    
    private enum CodingKeys: String, CodingKey {
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genresApi = try container.decode([GenreApi].self, forKey: .genres)
    }
    
}
