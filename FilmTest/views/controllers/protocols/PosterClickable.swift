//
//  PosterClickable.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 04.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit

protocol PosterClickable {
    var poster: UIImageView { get }
}

extension PosterClickable where Self: UIViewController {
    
    func setPosterTapped() {
        let tapGesture = UITapGestureRecognizer(target: Self, action: #selector(zoomImageToFullScreen))
        poster.isUserInteractionEnabled = true
        tapGesture.numberOfTapsRequired = 1
        poster.addGestureRecognizer(tapGesture)
    }
    
    @objc @objc fileprivate func zoomImageToFullScreen() {
        if isFullScreen {
            // unzoom
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = .white
                self.setAlpha(alpha: 1)
                self.removePosterFromSuperview()
            })
            isFullScreen = false
            
        } else {
            // zoom
            let posterWidth: CGFloat = 320
            let posterHeight: CGFloat = 480
            let coordX: CGFloat = view.center.x - (posterWidth / 2)
            let coordY: CGFloat = view.center.y - (posterHeight / 2)
            let posterframe = CGRect(x: coordX, y: coordY, width: posterWidth, height: posterHeight)
            let posterImageView = UIImageView(frame: posterframe)
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.view.backgroundColor = .black
                self.setAlpha(alpha: 0)
                self.addPosterOnSuperview(posterImageView)
            }) { (value) in
                self.setImage(on: posterImageView, by: .poster)
            }
            isFullScreen = true
        }
    }
    
}
