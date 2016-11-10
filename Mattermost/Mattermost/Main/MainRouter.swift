//
//  MainRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import SideMenuController

fileprivate let transitionDuration = 0.25

class MainRouter : NavigationRouting {
    
    var topViewController: UIViewController
    
    var sideMenu: SideMenuController
    
    var navigationController: UINavigationController {
        return tabBarController.selectedViewController as! UINavigationController
    }
    
    var tabBarController: UITabBarController {
        return sideMenu.centerViewController as! TabBarViewController
    }
    
    //MARK: - Init
    required init(withSideMenuController sideMenuController: SideMenuController) {
        self.sideMenu = sideMenuController
        topViewController = sideMenuController
    }
}
