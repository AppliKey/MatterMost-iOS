//
//  MenuCoordinator.swift
//  Mattermost
//
//  Created by iOS_Developer on 10.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import SideMenuController

class SideMenuCoordinator : SideMenuControllerDelegate {
    
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
        router.sideMenu.delegate = self
        router.sideMenu.embed(sideViewController: menu)
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        sideMenuCompletionBlock?()
        sideMenuCompletionBlock = nil
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        sideMenuCompletionBlock?()
        sideMenuCompletionBlock = nil
    }
    
    fileprivate func closeSideMenu(withCompletion completion: VoidClosure?) {
        router.sideMenu.toggle()
        sideMenuCompletionBlock = completion
    }
}

extension SideMenuCoordinator : MenuCoordinator {
    
    func openSettings() {/*
        closeSideMenu { [unowned self] in
            guard let settingsVC = R.storyboard.main.settingsViewController()
                else { fatalError("Can't instantiate settings view controller") }
            settingsVC.hidesBottomBarWhenPushed = true
            
            self.router.push(viewController: settingsVC)
        }*/
        
        router.sideMenu.toggle()
        guard let settingsVC = R.storyboard.main.settingsViewController()
            else { fatalError("Can't instantiate settings view controller") }
        settingsVC.hidesBottomBarWhenPushed = true
        
        self.router.push(viewController: settingsVC)
    }
    
}
