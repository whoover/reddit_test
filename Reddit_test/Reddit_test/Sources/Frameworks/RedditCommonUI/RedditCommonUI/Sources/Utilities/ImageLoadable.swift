//
//  ImageLoadable.swift
//  RedditCommonUI
//
//  Created by Artem Belenkov on 14/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

public protocol ImageLoadableProtocol {
    static var defaultImage: UIImage? { get }
    
    func loadImage(_ imageURL: URL, _ identifier: UUID) -> CancellableProtocol?
    func resetToDefault()
}
