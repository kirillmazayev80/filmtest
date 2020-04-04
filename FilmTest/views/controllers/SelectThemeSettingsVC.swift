//
//  SelecThemeSettingsVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 17.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class SelectThemeSettingsVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var themesTable: UITableView!
    
    var viewModel: SelectThemeSettingsViewModel?
    weak var coordinator: SelectThemeSettingsCoordinator?
    
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // bind themes table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        // binding themes data source
        vm.themes.bind(to: themesTable, using: ThemesSettingsBinder())
        // binding did select delegate
        _ = themesTable.selectedIndexPath
            .observeNext { [unowned self] indexPath in
                let selectedTheme = vm.themes[indexPath.row]
                vm.applyTheme(selectedTheme)
                self.navigationController?.navigationBar.setStyle(by: selectedTheme)
                self.themesTable.reloadData()
        }
    }

}
