//
//  Storyboarded.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 07.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(sbName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(sbName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: sbName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
