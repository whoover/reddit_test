//
//  DataTask.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

class DataTask: CancellableProtocol {
    let identifier: String
    let task: URLSessionTask
    private(set) var isCanceled: Bool = false
    private var cancelBlock: EmptyBlock?
    
    init(task: URLSessionTask, identifier: String = UUID().uuidString, cancelBlock: EmptyBlock? = nil) {
        self.task = task
        self.identifier = identifier
        self.cancelBlock = cancelBlock
    }
    
    func cancel() {
        guard !isCanceled, cancelBlock != nil else {
            return
        }
        
        isCanceled = true
        task.cancel()
        cancelBlock?.execute(())
        cancelBlock = nil
    }
    
    func resume() {
        task.resume()
    }
}
