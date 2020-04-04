//
//  UICollectionViewCell.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 12.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    // set card view properties form cell
    func setCardViewProperties() {
        layer.cornerRadius = 5.0
        layer.shadowRadius = 9.0
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        clipsToBounds = false
    }
    
}
