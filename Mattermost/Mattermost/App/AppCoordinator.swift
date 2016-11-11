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
    
    func rootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        showAuthorization(withNavigationController: navigationController)
        return navigationController
    }
    
    func showAuthorization(withNavigationController navigationController: UINavigationController) {
        let router = AuthorizationRouter(withNavigationController: navigationController)
        let coordinator = AuthorizationCoordinator(withRouter: router, appCoordinator: self)
        coordinator.start()
    }
    
    func showMainScreen(withNavigationController navigationController: UINavigationController) {
        setupSideMenu()
        let sideMenu = SideMenuController()
        let router = MainRouter(withSideMenuController: sideMenu)
        let mainCoordinator = MainCoordinator(withRouter: router, appCoordinator: self)
        let menuCoordinator = SideMenuCoordinator(withRouter: router, coordinator: mainCoordinator)
        
        mainCoordinator.start()
        menuCoordinator.start()
    }
    
    fileprivate func setupSideMenu() {
        SideMenuController.preferences.drawing.menuButtonImage = R.image.icMenu()
        SideMenuController.preferences.drawing.centerPanelShadow = false
        SideMenuController.preferences.drawing.sidePanelPosition = .underCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 260
        SideMenuController.preferences.drawing.centerPanelOverlayColor = UIColor.black
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
    }
}
