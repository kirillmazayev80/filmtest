//
//  AppDelegate.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 20.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setDefaultAppSettings()
        setNetworkReachabilityManager()
        return true
    }

    // MARK: - Custom
    fileprivate func setDefaultAppSettings() {
        if (UserDefaults.standard.string(forKey: Utils.APP_THEME) == nil && UserDefaults.standard.string(forKey: Utils.GENRE_NAME) == nil) {
            UserDefaults.standard.set(Utils.DEF_THEME, forKey: Utils.APP_THEME)
            UserDefaults.standard.set(Utils.DEF_GENRE.name,
                                      forKey: Utils.GENRE_NAME)
            UserDefaults.standard.set(Utils.DEF_GENRE.id, forKey: Utils.GENRE_ID)
        }
    }
    
    fileprivate func setNetworkReachabilityManager() {
        NetworkManager.shared.startNetworkReachabilityObserver()
    }
    
}

