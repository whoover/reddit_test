//
//  UserDefautlsDataStorage.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class UserDefautlsDataStorage: DataStorageProtocol {
    static let itemsStorageKey = "itemsStorageKey"
    static let afterStorageKey = "afterStorageKey"
    
    private let userDefaults: UserDefaults
    
    init(userDefautls: UserDefaults = .standard) {
        self.userDefaults = userDefautls
    }
    
    func save<T: Codable>(items: [T]) {
        let data = try? JSONEncoder().encode(items)
        userDefaults.setValue(data, forKey: type(of: self).itemsStorageKey)
        userDefaults.synchronize()
    }
    
    func save(after: String?) {
        userDefaults.setValue(after, forKey: type(of: self).afterStorageKey)
        userDefaults.synchronize()
    }
    
    func getItems<T>() -> [T] where T: Codable {
        guard let data = userDefaults.data(forKey: type(of: self).itemsStorageKey) else {
            return []
        }
        let items = try? JSONDecoder().decode([T].self, from: data)
        return items ?? []
    }
    
    func getAfter() -> String? {
        userDefaults.string(forKey: type(of: self).afterStorageKey)
    }
    
    func cleanupData() {
        userDefaults.removeObject(forKey: type(of: self).afterStorageKey)
        userDefaults.removeObject(forKey: type(of: self).itemsStorageKey)
        userDefaults.synchronize()
    }
}
