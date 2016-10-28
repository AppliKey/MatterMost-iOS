//
//  AuthorizationCoordinator.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationCoordinator {
    
    func startViewController() -> UIViewController {
        guard let viewController = R.storyboard.authorization.serverSelectionViewController() else { fatalError("Can't instantiate server selection view controller") }
        
        return viewController
    }
    
}
