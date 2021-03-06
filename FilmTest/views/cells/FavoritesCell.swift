//
//  FavoritesCell.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 25.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import SDWebImage

class FavoritesCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var posterImg: UIImageView!
    @IBOutlet fileprivate weak var titleLbl: UILabel!


    func configureCell(with movie: Movie) {
        setCardViewProperties()
        posterImg.setCornerRadius(radius: 5.0)
        titleLbl.text = movie.title
        setPoster(by: movie)
    }
    
    fileprivate func setPoster(by movie: Movie) {
        let fetchPosterUrlStr = APIHelper.FETCH_IMAGE_URL
        if let posterPath = movie.posterPath,
            let posterUrl = URL(string: "\(fetchPosterUrlStr)\(posterPath)") {
            self.posterImg.sd_setImage(with: posterUrl, completed: nil)
        } else {
            let noImage = UIImage(named: Utils.POSTER_NO_IMAGE)
            self.posterImg.image = noImage
        }
    }
    
}
