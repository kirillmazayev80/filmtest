//
//  MovieEntity.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 13.05.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import RealmSwift

class MovieEntity: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var overview: Overview? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
