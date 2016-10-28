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
        return authorizationCoordinator.startViewController()
    }
    
    //MARK: Private
    fileprivate let authorizationCoordinator = AuthorizationCoordinator()
    
    private func startViewController() -> UIViewController {
        return R.storyboard.authorization.serverSelectionViewController()!
    }
  
}
