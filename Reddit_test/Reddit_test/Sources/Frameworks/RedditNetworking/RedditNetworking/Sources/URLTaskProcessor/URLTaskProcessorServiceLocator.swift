//
//  URLTaskProcessorServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol URLTaskProcessorServiceLocator {
    static func taskProcessor(session: NetworkSessionProtocol) -> URLTaskProcessorProtocol
}

extension URLTaskProcessorServiceLocator {
    public static func taskProcessor(session: NetworkSessionProtocol) -> URLTaskProcessorProtocol {
        return URLTaskProcessor(session: session)
    }
}
