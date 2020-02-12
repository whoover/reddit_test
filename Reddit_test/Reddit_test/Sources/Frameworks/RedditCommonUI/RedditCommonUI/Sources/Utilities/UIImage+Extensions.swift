//
//  UIImage+Extensions.swift
//  RedditCommonUI
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension UIImageView {
    public func aspectFitImageSize() -> CGSize? {
        guard let aspectRatio = image?.size else {
            return nil
        }
        return CGSizeAspectFit(aspectRatio: aspectRatio, boundingSize: bounds.size)
    }

    private func CGSizeAspectFit(aspectRatio: CGSize, boundingSize: CGSize) -> CGSize {
        var aspectFitSize = boundingSize
        let mW = boundingSize.width / aspectRatio.width
        let mH = boundingSize.height / aspectRatio.height
        if mH < mW {
            aspectFitSize.width = mH * aspectRatio.width
        } else if mW < mH {
            aspectFitSize.height = mW * aspectRatio.height
        }
        return aspectFitSize
    }
}
