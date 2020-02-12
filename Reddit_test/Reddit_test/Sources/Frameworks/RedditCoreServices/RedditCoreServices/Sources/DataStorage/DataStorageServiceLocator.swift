//
//  DataStorageServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public protocol DataStorageServiceLocator {
    func dataStorage() -> DataStorageProtocol
}

extension DataStorageServiceLocator {
    public func dataStorage() -> DataStorageProtocol {
        UserDefautlsDataStorage()
    }
}
