//
//  RedditApp.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

protocol AppProtocol {
    func applicationDidFinishLaunching(_ application: UIApplication,
                                       _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationDidReceiveRemoteNotification(_ application: UIApplication,
                                                 _ userInfo: [AnyHashable: Any],
                                                 _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    func applicationContinueUserActivity(_ application: UIApplication,
                                         _ userActivity: NSUserActivity,
                                         _ restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
}

final class RedditApp: AppProtocol {
    typealias ServiceLocator = AppCoordinatorServiceLocator
    final class ServiceLocatorImpl: ServiceLocator { }
    
    private let appCoordinator: AppCoordinatorProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        appCoordinator = serviceLocator.appCoordinator()
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication,
                                       _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure deep link
        let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: notification)
        appCoordinator.start(with: deepLink)
        
        return true
    }
    
    func applicationDidReceiveRemoteNotification(_ application: UIApplication,
                                                 _ userInfo: [AnyHashable: Any],
                                                 _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let dict = userInfo as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: dict)
        appCoordinator.start(with: deepLink)
    }
    
    func applicationContinueUserActivity(_ application: UIApplication,
                                         _ userActivity: NSUserActivity,
                                         _ restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let deepLink = DeepLinkOption.build(with: userActivity)
        appCoordinator.start(with: deepLink)
        
        return true
    }
}
