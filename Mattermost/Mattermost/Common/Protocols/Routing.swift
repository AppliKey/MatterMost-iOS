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
    func present(_ viewController: UIViewController, completion: VoidClosure?)
    func dismiss(completion: VoidClosure?)
}

extension Routing {
    
    func present(_ viewController: UIViewController, completion: VoidClosure? = nil) {
        topViewController.present(viewController, animated: true, completion: completion)
    }
    
    func dismiss(completion: VoidClosure? = nil) {
        topViewController.dismiss(animated: true, completion: completion)
    }
    
}

protocol NavigationRouting: Routing {
    var navigationController: UINavigationController {get}
    func push(_ viewController: UIViewController, animated: Bool)
    func pop()
    func root(_ viewController: UIViewController, animated: Bool)
}

extension NavigationRouting {
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        topViewController = viewController
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
        topViewController = navigationController.topViewController ?? navigationController
    }
    
    func root(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
    }
    
}
