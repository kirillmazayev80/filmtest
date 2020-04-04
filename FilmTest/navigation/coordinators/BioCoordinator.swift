//
//  BioCoordinator.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

class BioCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    fileprivate var actorId: String
    
    
    init(navigationController: UINavigationController, actorId: String) {
        self.navigationController = navigationController
        self.actorId = actorId
    }
    
    func start() {
        let vc = BiographyVC.instantiate(sbName: Utils.ACTORS_LIST_SB)
        let apiManager = FetchBioManager<BioApi>()
        let viewModel = BioViewModel(loader: apiManager, actorId: actorId)
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func transitToHomePage(with homePageUrlStr: String) {
        let child = HomePageCoordinator(navigationController: navigationController, homePageUrlStr: homePageUrlStr)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from)
            else { return }
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let homePageVC = fromViewController as? HomePageVC,
            let coordinator = homePageVC.coordinator {
            childDidFinish(coordinator)
        }
    }
    
}
