//
//  UITabBarItem.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 07.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

extension UITabBarItem {

    //set type of tab bar item by image & title
    func setTabBarItemType(title: String, imageName: String) {
        self.title = title
        image = UIImage(named: imageName)
    }

}
