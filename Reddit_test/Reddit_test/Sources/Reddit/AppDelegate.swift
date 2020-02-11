//
//  AppDelegate.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let service: NetworkingService = NetworkingService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let successBlock = BlockObject<RedditResponse, Void> { response in
            print("")
        }
        let errorBlock = BlockObject<Error, Void> { error in
            print("")
        }
        service.loadFrom(lastName: nil, successBlock: successBlock, errorBlock: errorBlock)
        
        return true
    }
}
