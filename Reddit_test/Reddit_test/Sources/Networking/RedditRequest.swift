//
//  RedditRequest.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

enum RedditRequest: RequestProtocol {
    case top(String?)
    
    var schema: String {
        "https"
    }
    
    var host: String {
        "www.reddit.com"
    }
    
    var path: String {
        switch self {
        case .top:
            return "/top.json"
        }
    }
    
    var parameters: [String: String?] {
        switch self {
        case .top(let after):
            return ["limit": "50", "after": after]
        }
    }
}
