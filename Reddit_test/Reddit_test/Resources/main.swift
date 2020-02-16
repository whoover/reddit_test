//
//  main.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 16.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

class FakeAppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if window == nil {
      window = UIWindow(frame: CGRect.zero)
    }
    self.window?.rootViewController = UIViewController()
    return true
  }
}

let isRunningTests = NSClassFromString("XCTestCase") != nil

let unsafeArgv = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
  .bindMemory(
    to: UnsafeMutablePointer<Int8>?.self,
    capacity: Int(CommandLine.argc))

if isRunningTests {
  _ = UIApplicationMain(CommandLine.argc,
                        unsafeArgv,
                        NSStringFromClass(UIApplication.self),
                        NSStringFromClass(FakeAppDelegate.self))
} else {
  _ = UIApplicationMain(CommandLine.argc,
                        unsafeArgv,
                        NSStringFromClass(UIApplication.self),
                        NSStringFromClass(AppDelegate.self))
}
