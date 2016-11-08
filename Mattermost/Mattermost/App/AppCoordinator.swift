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
        let router = MainRouter()
        let coordinator = MainCoordinator(withRouter: router, appCoordinator: self)
        coordinator.start()
    }
  
}
