//
//  Floaty.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 15.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Floaty

extension Floaty {
    
    func setProperties(size: CGFloat = 56,
                       paddX: CGFloat = 14,
                       paddY: CGFloat = 14,
                       btnColor: UIColor = UIColor(red: 73/255.0, green: 151/255.0, blue: 241/255.0, alpha: 1),
                       btnImage: UIImage? = nil,
                       tag: Int = 0,
                       friendlyTap: Bool = false) {
        self.size = size
        self.paddingX = paddX
        self.paddingY = paddY
        self.buttonColor = btnColor
        self.buttonImage = btnImage
        self.tag = tag
        self.friendlyTap = friendlyTap
    }
    
}
