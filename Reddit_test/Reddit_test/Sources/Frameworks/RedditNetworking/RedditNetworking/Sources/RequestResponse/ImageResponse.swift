//
//  ImageResponse.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public struct ImageResponse: ResponseProtocol {
    public let image: UIImage
    public var httpResponse: HTTPURLResponse
    
    public static func responseObject(_ data: Data?,
                                      _ response: HTTPURLResponse) throws -> ImageResponse {
        guard let data = data,
            let image = UIImage(data: data) else {
            throw DataError.noData
        }
        
        return ImageResponse(image: image, httpResponse: response)
    }
}
