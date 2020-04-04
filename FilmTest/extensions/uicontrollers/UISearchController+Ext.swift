//
//  UISearchController.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 13.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit


extension UISearchController {
    
    // Setup search controller for view controller
    func setSearchControllerProperties(viewController: UIViewController) {
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = Strings.SEARCH
        viewController.navigationItem.searchController = self
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        viewController.definesPresentationContext = true
    }
    
}
