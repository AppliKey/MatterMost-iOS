//
//  AppCoordinator.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    init(window: UIWindow) {
        self.window = window
        router = AppRouter(window: window)
    }
    
    func setup() {
        if SessionManager.shared.hasValidSession {
            showMainScreen()
        } else {
            showAuthorization()
        }
        window.makeKeyAndVisible()
    }
    
    func showAuthorization() {
        let navigationController = UINavigationController()
        let authorizationRouter = AuthorizationRouter(withNavigationController: navigationController)
        let authorizationCoordinator = AuthorizationCoordinator(withRouter: authorizationRouter,
                                                                appCoordinator: self)
        authorizationCoordinator.start()
        router.setRootController(navigationController)
    }
    
    func showMainScreen() {
        setupSideMenu()
        let sideMenuController = SideMenuController()
        let mainRouter = MainRouter(withSideMenuController: sideMenuController)
        let mainCoordinator = MainCoordinator(withRouter: mainRouter, appCoordinator: self)
        mainCoordinator.start()
        let menuCoordinator = SideMenuCoordinator(withRouter: mainRouter, coordinator: mainCoordinator)
        menuCoordinator.start()
        router.setRootController(sideMenuController)
    }
    
    fileprivate func setupSideMenu() {
        SideMenuController.preferences.drawing.menuButtonImage = R.image.icMenu()
        SideMenuController.preferences.drawing.centerPanelShadow = false
        SideMenuController.preferences.drawing.sidePanelPosition = .underCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 260
        SideMenuController.preferences.drawing.centerPanelOverlayColor = UIColor.black
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
    }
    
    //MARK: - Private -
    private let window: UIWindow
    private let router: AppRouter
    
}
