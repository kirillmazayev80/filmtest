//
//  ActorCell.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 21.06.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import SDWebImage

class ActorCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var cardView: UIView!
    @IBOutlet fileprivate weak var posterImg: UIImageView!
    @IBOutlet fileprivate weak var nameLbl: UILabel!

    
    func configureCell(with actor: Actor) {
        setCardViewProperties()
        self.nameLbl.text = actor.name
        setPoster(by: actor)
    }
    
    fileprivate func setPoster(by actor: Actor) {
        let fetchPosterUrlStr = APIHelper.FETCH_IMAGE_URL
        if let profilePath = actor.profilePath,
            let posterUrl = URL(string: "\(fetchPosterUrlStr)\(profilePath)") {
            self.posterImg.sd_setImage(with: posterUrl, completed: nil)
        } else {
            let noImage = UIImage(named: Utils.POSTER_NO_IMAGE)
            posterImg.image = noImage
        }
    }
    
}
