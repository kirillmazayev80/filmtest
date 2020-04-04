//
//  Theme.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 19.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

enum Theme: String {
    
    case light = "Light"
    case dark = "Dark"
    
    //Customizing the navigation bar
    var barStyle: UIBarStyle {
        switch self {
            case .light: return .default
            case .dark: return .black
        }
    }

}
