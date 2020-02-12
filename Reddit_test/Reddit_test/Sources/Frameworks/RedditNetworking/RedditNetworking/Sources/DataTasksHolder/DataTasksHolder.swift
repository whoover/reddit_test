//
//  DataTasksHolder.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

public protocol DataTasksHolderProtocol {
    func add(_ task: DataTaskProtocol?)
    func remove(_ identifier: String)
    func cancel(_ identifier: String)
    func cancelAll()
}

public final class DataTasksHolder: DataTasksHolderProtocol {
    private let dataTasksSyncQueue = DispatchQueue(label: "com.reddit.NetworkingManager.dataTasksSyncQueue")
    private(set) var dataTasks: [String: DataTaskProtocol] = [:]
    
    public func add(_ task: DataTaskProtocol?) {
        guard let task = task else {
            return
        }
        
        dataTasksSyncQueue.sync {
            dataTasks[task.identifier] = task
        }
    }
    
    public func remove(_ identifier: String) {
        dataTasksSyncQueue.sync {
            dataTasks[identifier] = nil
        }
    }
    
    public func cancel(_ identifier: String) {
        dataTasksSyncQueue.sync {
            dataTasks[identifier]?.cancel()
        }
        remove(identifier)
    }
    
    public func cancelAll() {
        dataTasks.forEach { $0.value.cancel() }
        dataTasksSyncQueue.sync {
            dataTasks = [:]
        }
    }
}
