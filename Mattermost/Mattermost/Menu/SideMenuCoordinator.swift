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
    init(withRouter router: MainRouting, coordinator: MainCoordinator) {
        self.router = router
        self.coordinator = coordinator
    }
    
    fileprivate let router: MainRouting
    fileprivate unowned let coordinator: MainCoordinator

    func start() {
        guard let menu = R.storyboard.menu.menuViewController()
            else { fatalError("Can't instantiate left menu view controller") }
        MenuWireframe.setup(menu, withCoordinator: self)
        router.embed(sideViewController: menu)
    }
    
    //MARK: - Private
    
    fileprivate func push(_ viewController: UIViewController) {
        router.toggleMenu()
        viewController.hidesBottomBarWhenPushed = true
        self.router.push(viewController, animated: false)
    }
    
}

extension SideMenuCoordinator : MenuCoordinator {
    
    func openSettings() {
        guard let viewController = R.storyboard.menu.settingsViewController()
            else { fatalError("Can't instantiate settings view controller") }
        SettingsWireframe.setup(viewController, withCoordinator: self)
        push(viewController)
    }
    
    func createGroup() {
        guard let viewController = R.storyboard.menu.newGroupViewController()
            else { fatalError("Can't instantiate settings view controller") }
        NewGroupWireframe.setup(viewController, withCoordinator: self)
        push(viewController)
    }
    
}

extension SideMenuCoordinator : SettingsCoordinator {
    func checkTabBarControllers() {
        coordinator.checkTabBarControllers()
    }
    
    func showAuthorization() {
        coordinator.showAuthorization()
    }
}

extension SideMenuCoordinator: NewGroupCoordinator {}
