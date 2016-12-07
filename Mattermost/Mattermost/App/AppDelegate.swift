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
        AppearanceManager.setupDefaultAppearance()
        Fabric.with([Crashlytics.self])
        return true
    }
    
    //MARK: Private
    private let appCoordinator = AppCoordinator()
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController()
        window?.makeKeyAndVisible()
        if SessionManager.shared.hasValidSession {
            appCoordinator.showMainScreen()
        }
    }

}


