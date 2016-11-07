//
//  MainRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: NavigationRouting {
    
    let navigationController: UINavigationController
    var topViewController: UIViewController
    
    //MARK: - Init
    required init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        topViewController = navigationController.topViewController ?? navigationController
    }
    
    func leftToRightPush(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        topViewController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(viewController, animated: true)
        topViewController = viewController
    }
}
