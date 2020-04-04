//
//  AppSettings.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 16.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class AppSettingsVC: UITableViewController, Storyboarded {
    
    var viewModel: AppSettingsViewModel?
    weak var coordinator: AppSettingsCoordinator?
    
    
    // UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let vm = self.viewModel else { return }
        vm.updateSettings()
        tableView.reloadData()
    }

    // bind settings table
    fileprivate func bindViewModel() {
        _ = tableView.selectedIndexPath
            .observeNext { [unowned self] (indexPath) in
                switch (indexPath.section) {
                    case 0: self.coordinator?.transitToSelectThemeSettings()
                    case 1: self.coordinator?.transitToSelectGenreSettings()
                    default : break
                }
            }
    }
    
}
