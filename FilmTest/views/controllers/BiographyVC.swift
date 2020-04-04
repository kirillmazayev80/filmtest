//
//  BioVC.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 22.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond


class BiographyVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var portraitImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var birthPlaceLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var homepageLbl: UILabel!
    @IBOutlet weak var bioTxt: UITextView!
    
    var viewModel: BioViewModel?
    weak var coordinator: BioCoordinator?
    
    
    // UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // Bind biography details
    fileprivate func bindViewModel() {
        guard let vm = self.viewModel else { return }
        
        _ = vm.bio
            .observeNext { [unowned self] (bio) in
                if let bio = bio { BioBinder.setBio(vc: self, bio) }
        }
        
        _ = vm.errorMessages
            .observeNext { [unowned self] (text) in
                self.showErrorMessage(title: Strings.REQUEST_ERR_TITLE,
                                      errorText: text)
        }
        
        homepageLbl.reactive.tapGesture()
            .bind(to: self) { [unowned self] (target, gesture) in
                guard let urlStr = self.homepageLbl.attributedText?.string else { return }
            self.coordinator?.transitToHomePage(with: urlStr)
        }
    }
    
}
