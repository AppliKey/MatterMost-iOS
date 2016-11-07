//
//  AuthorizationRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/4/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationRouter: NavigationRouting {
    
    let navigationController: UINavigationController
    var topViewController: UIViewController
    
    //MARK: - Init
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        topViewController = navigationController.topViewController ?? navigationController
    }
    
}
