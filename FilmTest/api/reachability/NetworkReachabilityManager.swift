//
//  NetworkReachabilityManager.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 25.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    private init(){}
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: APIHelper.BASE_URL)
    
    func startNetworkReachabilityObserver() {
        // define Alamofire Reachability Manager
        // start listening
        reachabilityManager?.startListening(onUpdatePerforming: {
            status in
            switch status {
            case .notReachable:
                NotificationCenter.default.post(name: .notReachable, object: nil)
                print("The network is not reachable")
            case .unknown :
                NotificationCenter.default.post(name: .unknown, object: nil)
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                NotificationCenter.default.post(name: .reachableEthernetOrWiFi, object: nil)
                print("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                NotificationCenter.default.post(name: .reachableCellular, object: nil)
                print("The network is reachable over the cellular connection")
            }
        })
    }
}

extension Notification.Name {
    
    static let notReachable = Notification.Name("notReachable")
    static let unknown = Notification.Name("unknown")
    static let reachableEthernetOrWiFi = Notification.Name("reachableEthernetOrWiFi")
    static let reachableCellular = Notification.Name("reachableCellular")
    
}
