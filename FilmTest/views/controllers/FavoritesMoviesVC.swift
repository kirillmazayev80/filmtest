//
//  FavoritesMoviesVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 26.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class FavoritesMoviesVC: UIViewController, UICollectionViewDelegate,
                            Storyboarded {

    @IBOutlet weak var favoritesGallery: UICollectionView!
    @IBOutlet weak var sortFavoritesSegmCtrl: UISegmentedControl!
    
    var viewModel: FavoritesViewModel?
    weak var coordinator: FavoritesMoviesCoordinator?
    
    // MARK: - UITableViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    // MARK: - Custom
    fileprivate func setUserInterface(){
        favoritesGallery.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        vm.sortingType
            .bidirectionalBind(to: sortFavoritesSegmCtrl.reactive.selectedSegmentIndex)
        
        vm.sortedMovies.bind(to: favoritesGallery, using: FavoritesMoviesBinder())
        
        _ = favoritesGallery.selectedRow
            .observeNext { [unowned self] (row) in
                let movie = vm.sortedMovies.collection[row]
                self.coordinator?.transitToOverview(with: movie)
            }
        
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.INTERNAL_ERR_TITLE,
                                      errorText: text)
        }
    }
    
}
