//
//  String+Ext.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.05.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Foundation

extension String {
    
    // convert string to date
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    
    // string localizing
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
