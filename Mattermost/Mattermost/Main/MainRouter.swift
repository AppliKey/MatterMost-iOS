//
//  MainRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

fileprivate let transitionDuration = 0.2

class MainRouter {
    
    func pushFromLeft(fromViewController sender: UIViewController, to viewController:UIViewController) {
        let transition = CATransition()
        transition.duration = transitionDuration
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        sender.navigationController?.view?.layer.add(transition, forKey: kCATransition)
        sender.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func popToRight(fromViewController sender: UIViewController) {
        let transition = CATransition()
        transition.duration = transitionDuration
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        sender.navigationController?.view?.layer.add(transition, forKey: kCATransition)
        _ = sender.navigationController?.popViewController(animated: false)
    }
    
    func push(fromViewController sender: UIViewController, to viewController:UIViewController) {
        sender.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop(fromViewController sender: UIViewController) {
        _ = sender.navigationController?.popViewController(animated: true)
    }
}
