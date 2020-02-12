//
//  DataStorageProtocol.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol DataStorageProtocol {
    func save<T: Codable>(items: [T])
    func save(after: String)
    
    func getItems<T: Codable>() -> [T]
    func getAfter() -> String?
    
    func cleanupData()
}
