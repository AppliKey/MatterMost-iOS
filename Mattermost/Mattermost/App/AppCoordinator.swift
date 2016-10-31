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
        let viewController = authorizationCoordinator.startViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    //MARK: Private
    fileprivate let authorizationCoordinator = AuthorizationCoordinator()
  
}
