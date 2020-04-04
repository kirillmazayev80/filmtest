//
//  SettingsVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 16.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class SelectGenreSettingsVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var genresTable: UITableView!
    
    var viewModel: SelectGenreSettingsViewModel?
    weak var coordinator: SelectGenreSettingsCoordinator?
    
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Custom
    // bind genres table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        //binding data source
        vm.genres.bind(to: genresTable, using: GenresSettingsBinder())
        // binding did select delegate
        _ = genresTable.selectedIndexPath
            .observeNext { [unowned self] indexPath in
                let tappedGenre = vm.genres[indexPath.row]
                vm.storeGenre(tappedGenre)
                self.genresTable.reloadData()
            }
        // show error and reachability alerts
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
            }
    }
    
}
