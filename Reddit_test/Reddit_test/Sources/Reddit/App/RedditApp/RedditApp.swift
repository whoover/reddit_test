//
//  RedditApp.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

@_exported import UIKit
@_exported import RedditCommonUI
@_exported import RedditCommon

protocol AppProtocol {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationDidFinishLaunching(_ application: UIApplication,
                                       _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationDidReceiveRemoteNotification(_ application: UIApplication,
                                                 _ userInfo: [AnyHashable: Any],
                                                 _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    func applicationContinueUserActivity(_ application: UIApplication,
                                         _ userActivity: NSUserActivity,
                                         _ restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    
    func application(_ application: UIApplication,
                     shouldSaveApplicationState coder: NSCoder) -> Bool
    func application(_ application: UIApplication,
                     shouldRestoreApplicationState coder: NSCoder) -> Bool
}

final class RedditApp: AppProtocol {
    typealias ServiceLocator = AppCoordinatorServiceLocator & AppAppearenceLocator
    final class ServiceLocatorImpl: ServiceLocator { }
    
    private let appCoordinator: AppCoordinatorProtocol
    private let appAppearence: AppAppearenceProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        appCoordinator = serviceLocator.appCoordinator()
        appAppearence = serviceLocator.appAppearence()
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication,
                                       _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure deep link
        let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
        let deepLink = DeepLinkOption.build(with: notification)
        handleLaunch()
        appCoordinator.start(with: deepLink)
        appAppearence.setup()
        
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
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        true
    }
    
    private func handleLaunch() {
      let launchHandler = CommandLineLaunchHandler()
      launchHandler.handleLaunch()
    }
}
