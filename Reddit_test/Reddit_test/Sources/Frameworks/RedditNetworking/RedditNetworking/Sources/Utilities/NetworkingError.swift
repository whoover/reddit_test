//
//  NetworkingError.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public enum NetworkingError: Error {
    case wrongURL
    case response(HTTPResponse)
    case dataTaskError(Error)
    case responseDecoding(Error)
    case unknown
}
