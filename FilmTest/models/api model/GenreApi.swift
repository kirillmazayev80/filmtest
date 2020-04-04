//
//  GenreApi.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 03.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

struct GenreApi: Decodable {
    
    var id: Int = 0
    var name: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {self.id = try container.decode(Int.self, forKey: .id)} catch {}
        do {self.name = try container.decode(String.self, forKey: .name)} catch {}
    }
    
    func convert() -> Genre {
        return Genre.init(id: self.id, name: self.name)
    }
    
}
