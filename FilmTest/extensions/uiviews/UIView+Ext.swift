//
//  View+CornerRadius.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 26.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

extension UIView {
    
    // set corner radius for view
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}
