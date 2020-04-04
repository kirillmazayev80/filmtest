//
//  Actor.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

struct Actor: Equatable {
    
    var id: Int
    var name: String
    var gender: Int
    var popularity: Double
    var profilePath: String?
    
    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.id == rhs.id
    }
    
}
