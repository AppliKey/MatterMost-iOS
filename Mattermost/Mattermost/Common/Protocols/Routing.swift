//
//  Routing.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol Routing: class {
    var topViewController: UIViewController {get set}
    func present(viewController: UIViewController, completion: VoidClosure?)
    func dismiss(completion: VoidClosure?)
}

extension Routing {
    
    func present(viewController: UIViewController, completion: VoidClosure? = nil) {
        topViewController.present(viewController, animated: true, completion: completion)
    }
    
    func dismiss(completion: VoidClosure? = nil) {
        topViewController.dismiss(animated: true, completion: completion)
    }
    
}

protocol NavigationRouting: Routing {
    var navigationController: UINavigationController {get}
    func push(viewController: UIViewController)
    func pop()
    func root(viewController: UIViewController)
}

extension NavigationRouting {
    
    func push(viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
        topViewController = viewController
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
        topViewController = navigationController.topViewController ?? navigationController
    }
    
    func root(viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }
    
}
