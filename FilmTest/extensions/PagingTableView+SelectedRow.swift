//
//  PagingTableView+SelectedRow.swift
//  FilmTest
//
//  Created by Kirill Mazaev on 19.04.2019.
//  Copyright © 2019 mazaev. All rights reserved.
//

import UIKit
import PagingTableView
import Bond
import ReactiveKit

extension PagingTableView {
    
    var selectedRowPTV: Signal<Int, NoError> {
        return reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)))
        { (subject: SafePublishSubject<Int>, _: UITableView, indexPath: IndexPath) in
            subject.next(indexPath.row)
        }
    }
    
}
