//
//  MenuCoordinator.swift
//  Mattermost
//
//  Created by iOS_Developer on 10.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class SideMenuCoordinator {
    
    //MARK: - Init
    init(withRouter router: MainRouter, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }
    
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    fileprivate var sideMenuCompletionBlock : VoidClosure?

    func start() {
        guard let menu = R.storyboard.main.menuViewController()
            else { fatalError("Can't instantiate left menu view controller") }
        MenuWireframe.setup(menu, withCoordinator: self)
        router.sideMenu.embed(sideViewController: menu)
    }
}

extension SideMenuCoordinator : MenuCoordinator {
    
    func openSettings() {
        router.sideMenu.toggle()
        guard let settingsVC = R.storyboard.main.settingsViewController()
            else { fatalError("Can't instantiate settings view controller") }
        settingsVC.hidesBottomBarWhenPushed = true
        
        self.router.push(viewController: settingsVC, animated: false)
    }
    
}
