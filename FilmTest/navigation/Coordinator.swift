//
//  Coordinator.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 07.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    var childCoordinators: [Coordinator] { get {return [] } set{} }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
