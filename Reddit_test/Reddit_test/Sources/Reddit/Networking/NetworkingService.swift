//
//  NetworkingService.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking
import RedditCommon

class NetworkingService {
    private let networkingManager = NetworkingManager(session: .shared, syncQueue: .main)
    
    func loadFrom(lastName: String?,
                  successBlock: BlockObject<RedditResponse, Void>,
                  errorBlock: BlockObject<Error, Void>) {
        networkingManager.sendGetRequest(request: RedditRequest.top(lastName),
                                         successBlock: successBlock,
                                         errorBlock: errorBlock)
    }
}
