//
//  WKWebView.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 09.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import WebKit

extension WKWebView {
    
    // convert string to url and load request
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        load(request)
    }
    
}
