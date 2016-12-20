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
    private var appCoordinator: AppCoordinator!
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { fatalError("No window") }
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.setup()
    }

}


