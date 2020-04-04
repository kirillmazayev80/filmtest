//
//  PosterZoomable.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 04.07.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import Bond
import SDWebImage

protocol PosterZoomable: class {
    var isFullScreen: Bool { get set }
    var poster: UIImageView { get }
    var posterPath: String { get }
    var backdropPath: String { get }
}

enum ImageType {
    case poster, backdrop
}

extension PosterZoomable where Self: UIViewController {
    
    func resizePosterFrame() {
        isFullScreen ? posterUnzoom() : posterZoom()
    }
    
    func posterZoom() {
        let posterImageView = UIImageView(frame: posterFrame())
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.view.backgroundColor = .black
            self.view.subviews.forEach({ $0.alpha = 0 })
            self.addPosterOnSuperview(posterImageView)
        }) { [unowned self] (value) in
            self.setImage(on: posterImageView, by: .poster)
        }
        isFullScreen = true
    }
    
    func posterFrame() -> CGRect {
        let posterWidth: CGFloat = view.frame.width
        let posterHeight: CGFloat = Dims.POSTER_HEIGHT * posterWidth / Dims.POSTER_WIDTH
        let coordX: CGFloat = view.center.x - (posterWidth / 2)
        let coordY: CGFloat = view.center.y - (posterHeight / 2)
        return CGRect(x: coordX, y: coordY, width: posterWidth, height: posterHeight)
    }
    
    func posterUnzoom() {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.view.backgroundColor = .white
            self.view.subviews.forEach({ $0.alpha = 1 })
            self.removePosterFromSuperview()
        })
        isFullScreen = false
    }
    
   func addPosterOnSuperview(_ poster: UIImageView) {
        poster.isUserInteractionEnabled = true
        poster.tag = Utils.POSTER_TAG
        poster.reactive.tapGesture()
            .bind(to: self) { [unowned self] _, _ in
                self.resizePosterFrame()
        }
        self.view.addSubview(poster)
    }
    
    func removePosterFromSuperview() {
        if let viewWithTag = self.view.viewWithTag(Utils.POSTER_TAG) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    func setImage(on imageView: UIImageView? = nil, by type: ImageType) {
        let fetchPosterStr = APIHelper.FETCH_IMAGE_URL
        switch (type) {
        case .poster:
            if let imagePathURL = URL(string: "\(fetchPosterStr)\(posterPath)") {
                imageView?.sd_setImage(with: imagePathURL, completed: nil)
            }
        case .backdrop:
            if let imagePathURL = URL(string: "\(fetchPosterStr)\(backdropPath)") {
                poster.sd_setImage(with: imagePathURL, completed: nil)
            }
        }
    }
    
}
