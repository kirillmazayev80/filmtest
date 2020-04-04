//
//  SelectThemeSettingsCoordinator.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

class SelectThemeSettingsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SelectThemeSettingsVC.instantiate(sbName: Utils.APP_SETTINGS_SB)
        let viewModel = SelectThemeSettingsViewModel()
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
