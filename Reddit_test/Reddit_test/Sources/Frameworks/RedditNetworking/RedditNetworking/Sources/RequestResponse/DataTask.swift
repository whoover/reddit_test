//
//  DataTask.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

public protocol DataTaskProtocol: CancellableProtocol, ResumableProtocol {
    var isCanceled: Bool { get }
    var identifier: String { get }
}

final class DataTask: DataTaskProtocol {
    let identifier: String
    let task: URLSessionTaskProtocol
    private(set) var isCanceled: Bool = false
    private var cancelBlock: EmptyBlock?
    
    init(task: URLSessionTaskProtocol,
         identifier: String = UUID().uuidString,
         cancelBlock: EmptyBlock? = nil) {
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
