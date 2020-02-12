//
//  NetworkSessionProtocol.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

public protocol NetworkSessionProtocol {
    func networkingDataTask(with url: URL,
                            identifier: String,
                            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void,
                            cancelBlock: EmptyBlock) -> DataTaskProtocol
}

extension URLSession: NetworkSessionProtocol {
    public func networkingDataTask(with url: URL,
                                   identifier: String,
                                   completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void,
                                   cancelBlock: EmptyBlock) -> DataTaskProtocol {
        let task = dataTask(with: url, completionHandler: completionHandler)
        let dataTask = DataTask(task: task, identifier: identifier, cancelBlock: cancelBlock)
        return dataTask
    }
}
