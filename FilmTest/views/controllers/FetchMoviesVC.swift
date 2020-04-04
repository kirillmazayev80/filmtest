//
//  ViewController.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 20.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class FetchMoviesVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var sortMovieSegmCtrl: UISegmentedControl!
    
    fileprivate var refreshCtrl =  UIRefreshControl()
    
    var viewModel: FetchViewModel?
    weak var coordinator: FetchMoviesCoordinator?
    
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    fileprivate func setUserInterface() {
        moviesTable.addSubview(refreshCtrl)
    }
    
    // binding movies table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        vm.movies
            .bind(to: moviesTable, using: FetchMoviesBinder())
        
        _ = moviesTable.didScroll
            .observeNext { (value) in
                vm.isLoadingNextPage.value = value
            }

        _ = moviesTable.selectedIndexPath
            .observeNext { [unowned self] (indexPath) in
                let movie = vm.movies.collection[indexPath.row]
                self.coordinator?.transitToOverview(with: movie)
            }
        
        sortMovieSegmCtrl.reactive.selectedSegmentIndex.bind(to: vm.fetchingMoviesType)
        
        _ = vm.hasEndRefreshing
            .observeNext { [unowned self] (value) in
                if value {
                    self.refreshCtrl.endRefreshing()
                    vm.hasEndRefreshing.value = false
                }
            }
        
        _ = refreshCtrl.reactive
            .controlEvents(.valueChanged)
            .observeNext { [unowned self] _ in
                self.refreshCtrl.beginRefreshing()
                vm.refreshMovies()
        }
        
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
            }
    }

}
