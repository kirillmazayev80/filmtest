//
//  SelectGenreSettingsCoordinator.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

class SelectGenreSettingsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SelectGenreSettingsVC.instantiate(sbName: Utils.APP_SETTINGS_SB)
        let apiManager = FetchGenresManager<GenresListApi>()
        let viewModel = SelectGenreSettingsViewModel(loader: apiManager)
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
