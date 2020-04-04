//
//  OverviewMovieVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 01.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond
import Floaty

class OverviewMovieVC: UIViewController, Storyboarded, PosterZoomable {

    @IBOutlet weak var backdropImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var budgetLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var descrTxt: UITextView!
    
    var viewModel: OverviewViewModel?
    weak var coordinator: MovieOverviewCoordinator?
    
    var poster: UIImageView { return backdropImg }
    var posterPath: String { return viewModel?.overview.value?.posterPath ?? ""}
    var backdropPath: String { return viewModel?.movie?.backdropPath ?? ""}
    var isFullScreen = false
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let vm = viewModel else { return }
        vm.isAdded()
    }
    
    // Binding movie's overview details
    fileprivate func bindViewModel() {
        guard let vm = self.viewModel else { return }
        
        _ = vm.overview
            .observeNext { [unowned self] (overview) in
                if let overview = overview {
                    OverviewBinder.setOverview(vc: self, overview)
                }
            }
        
        _ = vm.hasAdded
            .observeNext { [unowned self] (hasAdded) in
                self.removeActionBtn()
                self.setFloatActionBtn()
        }
        
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
        }
        
        backdropImg.reactive.tapGesture()
            .bind(to: self) { [unowned self] (_, _) in
                self.resizePosterFrame()
        }
    }
   
}
