//
//  SearchMoviesVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 26.02.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class SearchMoviesVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var resultsTable: UITableView!

    var viewModel: SearchViewModel?
    weak var coordinator: SearchMoviesCoordinator?
    
    fileprivate var refreshCtrl =  UIRefreshControl()
    fileprivate var searchString = Observable<String>("")
    fileprivate var currentText = ""

    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    // MARK: - Set user interface
    fileprivate func setUserInterface() {
        setSearchController()
        resultsTable.addSubview(refreshCtrl)
    }
    
    // setting search controller
    fileprivate func setSearchController() {
        let searchCtrl = UISearchController(searchResultsController: nil)
        searchCtrl.searchBar.delegate = self
        searchCtrl.searchResultsUpdater = self
        searchCtrl.setSearchControllerProperties(viewController: self)
    }
    
    // MARK: - Bindings
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        vm.searchString
            .bidirectionalBind(to: searchString)
        
        vm.movies
            .bind(to: resultsTable, using: SearchMoviesBinder())

        _ = resultsTable.didScroll
            .observeNext { (value) in
                vm.isLoadingNextPage.value = value
            }
        
        _ = resultsTable.selectedIndexPath
            .observeNext { [unowned self] (indexPath) in
                self.currentText = self.searchString.value
                let movie = vm.movies.collection[indexPath.row]
                self.coordinator?.transitToOverview(with: movie)
        }
        
        _ = refreshCtrl.reactive
            .controlEvents(.valueChanged)
            .observeNext { [unowned self] _ in
                self.refreshCtrl.beginRefreshing()
                vm.refreshMovies()
        }
        
        _ = vm.hasEndRefreshing
            .observeNext { [unowned self] (value) in
                if value {
                    self.refreshCtrl.endRefreshing()
                    vm.hasEndRefreshing.value = false
                }
        }
        
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
        }
    }
    
}

// UISearchResultUpdating
extension SearchMoviesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != currentText { searchString.value = text }
    }
    
}

// UISearchBarDelegate
extension SearchMoviesVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let vm = viewModel else { return }
        vm.clearResultsTable()
        currentText = ""
    }
    
}
