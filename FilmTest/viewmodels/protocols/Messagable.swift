//
//  Messagable.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 25.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import Bond
import ReactiveKit


protocol Messagable {
    var errorMessages: PassthroughSubject<String, Never> { get }
}

extension Messagable {
    
    var bag: DisposeBag { return DisposeBag() }
    
    func sendErrorMessage(text: String, name: String, error: Error) {
        self.errorMessages.send(text)
        print("\(name) ERROR: \(error.localizedDescription)")
    }
    
    func sendReachabilityMessage(errorMessage: PassthroughSubject<String, Never>) {
        NotificationCenter.default.reactive
            .notification(name: .notReachable)
            .observeNext { notification in
                errorMessage.send(Strings.INET_IS_NOT_REACH)
                print("Got \(notification)")
            }.dispose(in: bag)
        
        NotificationCenter.default.reactive
            .notification(name: .unknown)
            .observeNext { notification in
                errorMessage.send(Strings.INET_UKNOWN_REACH)
                print("Got \(notification)")
            }.dispose(in: bag)
        
        NotificationCenter.default.reactive
            .notification(name: .reachableEthernetOrWiFi)
            .observeNext { notification in
                errorMessage.send(Strings.INET_WIFI_IS_REACH)
                print("Got \(notification)")
            }.dispose(in: bag)
        
        NotificationCenter.default.reactive
            .notification(name: .reachableCellular)
            .observeNext { notification in
                errorMessage.send(Strings.INET_CELL_IS_REACH)
                print("Got \(notification)")
            }.dispose(in: bag)
    }
    
}
