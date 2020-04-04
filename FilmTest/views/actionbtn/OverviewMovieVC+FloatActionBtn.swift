//
//  OverviewMovieVC+FloatActionBtn.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 15.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Floaty

extension OverviewMovieVC {
    
    func setFloatActionBtn() {
        guard let vm = viewModel else { return }
        switch (vm.hasAdded.value) {
            case true: createDelActionBtn()
            case false: createAddActionBtn()
        }
    }
    
    fileprivate func createAddActionBtn() {
        let fabBtn = Floaty()
        fabBtn.setProperties(paddY: 64,
                             btnColor: Colors.GREEN,
                             btnImage: UIImage(named: Utils.ADD_FAB_ICON),
                             tag: Utils.FAB_TAG)
        fabBtn.reactive.tapGesture()
            .bind(to: self) { [unowned self] _, _ in
                self.onAddMovieToFavorites()
        }
        view.addSubview(fabBtn)
    }
    
    fileprivate func createDelActionBtn() {
        let fabBtn = Floaty()
        fabBtn.setProperties(size: 42,
                             paddX: self.view.frame.width - 56,
                             paddY: self.view.frame.height - 120,
                             btnColor: Colors.RED,
                             btnImage: UIImage(named: Utils.DELETE_FAB_ICON),
                             tag: Utils.FAB_TAG)
        fabBtn.reactive.tapGesture()
            .bind(to: self) { [unowned self] _, _ in
                self.onDeleteMovieFromFavorites()
        }
        view.addSubview(fabBtn)
    }
    
    func removeActionBtn() {
        if let viewWithTag = self.view.viewWithTag(Utils.FAB_TAG) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    fileprivate func onAddMovieToFavorites() {
        guard let vm = viewModel else { return }
        vm.onAddMovie()
        makeToast(with: Strings.HAS_ADDED_ALERT)
        vm.hasAdded.value.toggle()
    }
    
    fileprivate func onDeleteMovieFromFavorites() {
        guard let vm = viewModel else { return }
        vm.onRemoveMovie()
        makeToast(with: Strings.HAS_REMOVED_ALERT)
        vm.hasAdded.value.toggle()
    }
    
}
