//
//  UICollectionView+Ext.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 23.05.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import ReactiveKit


extension UICollectionView {
    
    // returns number of selected cell
    var selectedRow: Signal<Int, Never> {
        return reactive.delegate.signal(for: #selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:)))
        { (subject: PassthroughSubject<Int, Never>, _: UICollectionView, indexPath: IndexPath) in
            subject.send(indexPath.row)
        }
    }
    
}
