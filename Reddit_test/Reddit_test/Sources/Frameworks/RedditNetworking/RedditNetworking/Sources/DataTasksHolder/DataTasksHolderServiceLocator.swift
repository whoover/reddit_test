//
//  DataTasksHolderServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol DataTasksHolderServiceLocator {
    static func dataTasksHolder() -> DataTasksHolderProtocol
}

extension DataTasksHolderServiceLocator {
    static func dataTasksHolder() -> DataTasksHolderProtocol {
        return DataTasksHolder()
    }
}
