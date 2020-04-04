//
//  MovieOverviewCoordinator.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 07.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

class MovieOverviewCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    fileprivate var movie: Movie
    
    
    init(navigationController: UINavigationController, movie: Movie){
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        let vc = OverviewMovieVC.instantiate(sbName: Utils.MOVIE_OVERVIEW_SB)
        let apiManager = FetchOverviewManager<OverviewApi>()
        let viewModel = OverviewViewModel(loader: apiManager, movie: movie)
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
