//
//  UIScrollView.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 11.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // returns bool value when scroll view has scrolled
    func  isNearBottomEdge(edgeOffset: CGFloat = 30.0) -> Bool {
        return contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
    
}
