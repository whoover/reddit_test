//
//  HTTPResponse.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public enum HTTPResponse {
    case informational
    case success
    case redirection
    case client
    case server
    
    init?(value: Int) {
        switch value {
        case 100...199:
            self = .informational
        case 200...299:
            self = .success
        case 300...399:
            self = .redirection
        case 400...499:
            self = .client
        case 500...599:
            self = .server
        default:
            return nil
        }
    }
}
