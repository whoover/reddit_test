//
//  SimpleRequest.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public struct SimpleRequest: Requestable {
    public var url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
}
