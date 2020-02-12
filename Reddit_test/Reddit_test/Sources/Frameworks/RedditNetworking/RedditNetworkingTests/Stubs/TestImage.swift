//
//  TestImage.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension UIImage {
    static var testImage: UIImage! {
        let image = UIImage(named: "testImage",
                            in: Bundle(for: TestNetworkingManager.self),
                            compatibleWith: nil)
        return image
    }
    
    static var testImageData: Data! {
        testImage.pngData()
    }
}
