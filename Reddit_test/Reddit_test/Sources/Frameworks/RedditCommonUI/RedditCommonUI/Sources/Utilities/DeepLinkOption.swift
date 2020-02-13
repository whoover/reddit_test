//
//  DeepLinkOption.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public enum DeepLinkOption {
    case main
    case photo(URL)
    
    public static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        return nil
    }
    
    public static func build(with dict: [String: AnyObject]?) -> DeepLinkOption? {
        guard let screen = dict?["screen"] as? String else {
            return nil
        }
        //let itemID = dict?["item_id"] as? String
        
        switch screen {
        case DeepLinkOption.main.identificator():
            return .main
        //case DeepLinkConstants.item: return .item(itemID)
        default:
            return nil
        }
    }
    
    private func identificator() -> String {
        switch self {
        case .main:
            return "main"
        case .photo:
            return "story"
        }
    }
}
