//
//  AppDelegate.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 13.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupPushNotifications()
        AppearanceManager.setupDefaultAppearance()
        Fabric.with([Crashlytics.self])
        return true
    }
    
    //MARK: Private
    private var appCoordinator: AppCoordinator!
    private var notificationsHandler: NotificationsHandler!
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { fatalError("No window") }
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.setup()
    }
    
    //MARK: - Push notifications
    
    private func setupPushNotifications() {
        notificationsHandler = NotificationsHandler()
        notificationsHandler.register()
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        notificationsHandler.sendToken(deviceToken)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Did fail to register for remote notifications: \(error)")
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //TODO: handle
    }

}


