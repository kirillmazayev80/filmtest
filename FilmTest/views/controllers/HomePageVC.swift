//
//  HomePageVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 09.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import WebKit

class HomePageVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var homePage: String?
    var coordinator: HomePageCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        loadHomePage()
    }
    
    fileprivate func setUserInterface() {
        title = Strings.HOME_PAGE_TITLE
        indicator.startAnimating()
        webView.navigationDelegate = self
        indicator.hidesWhenStopped = true
    }
    
    fileprivate func loadHomePage() {
        guard let urlStr = self.homePage else { return }
        webView.load(urlStr)
    }
    
}

extension HomePageVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicator.stopAnimating()
    }
    
}
