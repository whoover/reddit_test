//
//  URLSessionTaskProtocol.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

protocol URLSessionTaskProtocol: CancellableProtocol, ResumableProtocol { }

extension URLSessionDataTask: URLSessionTaskProtocol { }
