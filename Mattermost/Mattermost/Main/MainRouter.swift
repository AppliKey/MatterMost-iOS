//
//  MainRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {
    
    fileprivate var sideMenu: SideMenuController
    
    fileprivate var tabBarController: UITabBarController {
        return sideMenu.centerViewController as! UITabBarController
    }
    
    var topViewController: UIViewController
    
    //MARK: - Init
    required init(withSideMenuController sideMenuController: SideMenuController) {
        self.sideMenu = sideMenuController
        topViewController = sideMenuController
    }
}

extension MainRouter : NavigationRouting {
    var navigationController: UINavigationController {
        return tabBarController.selectedViewController as! UINavigationController
    }
}

extension MainRouter : MainRouting {
    
    var rootController : UIViewController {
        return sideMenu
    }
    
    func embed(sideViewController controller: UIViewController) {
        sideMenu.embed(sideViewController: controller)
    }
    
    func embed(centerViewController controller: UIViewController) {
        sideMenu.embed(centerViewController: controller)
    }
    
    func toggleMenu() {
        sideMenu.toggle()
    }
    
    func addViewController(_ viewController: UIViewController) {
        if let viewControllers = tabBarController.viewControllers, viewControllers.count == 4 {
            tabBarController.viewControllers!.insert(viewController, at: 0)
        }
    }
    
    func deleteFirstViewController() {
        if let viewControllers = tabBarController.viewControllers, viewControllers.count == 5 {
            tabBarController.viewControllers!.remove(at: 0)
        }
    }
    
}
