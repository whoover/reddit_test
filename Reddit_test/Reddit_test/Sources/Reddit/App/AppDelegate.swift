//
//  AppDelegate.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var app = AppServiceLocatorImpl().app()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        app.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.applicationDidFinishLaunching(application, launchOptions)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification  userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        app.applicationDidReceiveRemoteNotification(application, userInfo, completionHandler)
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        app.applicationContinueUserActivity(application, userActivity, restorationHandler)
    }
    
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        app.application(application, shouldSaveApplicationState: coder)
    }
    
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        app.application(application, shouldRestoreApplicationState: coder)
    }
}
