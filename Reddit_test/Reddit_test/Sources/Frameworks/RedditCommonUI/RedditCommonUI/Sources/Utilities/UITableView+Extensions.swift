//
//  UITableView+Extensions.swift
//  RedditCommonUI
//
//  Created by Artem Belenkov on 14/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public extension UITableView {
    func reloadCellAtIndexIfNeeded(_ index: Int) {
       if indexPathsForVisibleRows?.contains(where: { $0.row == index }) == true {
           performBatchUpdates({ [weak self] in
               self?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
           }, completion: nil)
       }
   }
}
