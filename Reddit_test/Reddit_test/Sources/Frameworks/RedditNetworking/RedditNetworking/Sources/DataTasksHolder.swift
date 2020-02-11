//
//  DataTasksHolder.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

class DataTasksHolder {
    private let dataTasksSyncQueue = DispatchQueue(label: "com.reddit.NetworkingManager.dataTasksSyncQueue")
    private var dataTasks: [String: CancellableProtocol] = [:]
    
    func add(_ task: CancellableProtocol?) {
        guard let task = task else {
            return
        }
        
        dataTasksSyncQueue.sync {
            dataTasks[task.identifier] = task
        }
    }
    
    func remove(_ identifier: String) {
        dataTasksSyncQueue.sync {
            dataTasks[identifier] = nil
        }
    }
    
    func cancel(_ identifier: String) {
        dataTasksSyncQueue.sync {
            dataTasks[identifier]?.cancel()
            dataTasks[identifier] = nil
        }
    }
    
    func cancelAll() {
        dataTasks.forEach { $0.value.cancel() }
        dataTasksSyncQueue.sync {
            dataTasks = [:]
        }
    }
}
