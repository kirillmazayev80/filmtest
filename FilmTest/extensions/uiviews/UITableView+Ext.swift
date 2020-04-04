//
//  UITableView+SelectedRow.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 02.03.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import ReactiveKit


extension UITableView {
    
    // index path of selected row
    var selectedIndexPath: Signal<IndexPath, Never> {
        return reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)))
        { (subject: PassthroughSubject<IndexPath, Never>, _: UITableView, indexPath: IndexPath) in
            subject.send(indexPath)
        }
    }
    
    // returns bool signal if tableview has scrolled
    var didScroll: Signal<Bool, Never> {
        return reactive.delegate.signal(for: #selector(UIScrollViewDelegate.scrollViewDidScroll(_:)))
        {(subject: PassthroughSubject<Bool, Never>, _ scrollView: UIScrollView) in
            subject.send(scrollView.isNearBottomEdge())
        }
    }
    
    // returns tuple with cell and indexpath row when new cell will display
    var willDisplay: Signal<(UITableViewCell, Int), Never> {
        return reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:)))
        { (subject: PassthroughSubject<(UITableViewCell, Int), Never>, cell: UITableViewCell, indexPath: IndexPath) in
            subject.send((cell, indexPath.row))
        }
    }
    
}
