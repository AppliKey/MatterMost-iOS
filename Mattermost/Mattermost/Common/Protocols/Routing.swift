//
//  Routing.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol Routing {
    var viewController: UIViewController! {get set}
    func push(viewController: UIViewController)
    func present(viewController: UIViewController, completion: VoidClosure?)
    func pop()
    func dismiss(completion: VoidClosure?)
}

extension Routing {
    
    func push(viewController: UIViewController) {
        guard let navigationController = self.viewController.navigationController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController, completion: VoidClosure? = nil) {
        self.viewController.present(viewController, animated: true, completion: completion)
    }
    
    func pop() {
        guard let navigationController = viewController.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
    func dismiss(completion: VoidClosure? = nil) {
        viewController.dismiss(animated: true, completion: completion)
    }
    
}
