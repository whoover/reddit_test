//
//  ImageResponse.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

enum ImageDownloadError: Error {
    case noData
}

struct ImageResponse: ResponseProtocol {
    let image: UIImage
    
    public static func responseObject(_ data: Data?) throws -> ImageResponse {
        guard let data = data,
            let image = UIImage(data: data) else {
            throw ImageDownloadError.noData
        }
        
        return ImageResponse(image: image)
    }
}
