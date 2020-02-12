//
//  DataTasksHolderServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol DataTasksHolderServiceLocator {
    func dataTasksHolder() -> DataTasksHolderProtocol
}

extension DataTasksHolderServiceLocator {
    public func dataTasksHolder() -> DataTasksHolderProtocol {
        DataTasksHolder()
    }
}
