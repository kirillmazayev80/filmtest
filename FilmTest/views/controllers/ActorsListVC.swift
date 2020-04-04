//
//  ActorsVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond

class ActorsListVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var actorsTable: UITableView!
    
    fileprivate var refreshCtrl =  UIRefreshControl()
    
    var viewModel: ActorsListViewModel?
    weak var coordinator: ActorsListCoordinator?
    
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInterface()
        bindViewModel()
    }
    
    fileprivate func setUserInterface() {
        actorsTable.addSubview(refreshCtrl)
    }
    
    // Bind actors table
    fileprivate func bindViewModel() {
        guard let vm = viewModel else { return }
        
        vm.actors
            .bind(to: actorsTable, using: FetchActorsBinder())
        
        _ = actorsTable.didScroll
            .observeNext { (value) in
                vm.isLoadingNextPage.value = value
        }
        
        _ = actorsTable.selectedIndexPath
            .observeNext { [unowned self] (indexPath) in
                let actor = vm.actors.collection[indexPath.row]
                let actorId = String(actor.id)
                self.coordinator?.transitToBio(with: actorId)
        }
        
        _ = refreshCtrl.reactive
            .controlEvents(.valueChanged)
            .observeNext { [unowned self] _ in
                self.refreshCtrl.beginRefreshing()
                guard let vm = self.viewModel else { return }
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
