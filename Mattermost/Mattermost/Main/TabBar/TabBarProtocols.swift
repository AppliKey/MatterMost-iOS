//
//  TabBarTabBarProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarConfigurator: class {
}

protocol TabBarInteracting: class {
}

protocol TabBarPresenting: class {
}

protocol TabBarViewing: class {
    func showBadge(atController controller: TabBarControllers)
}

protocol TabBarEventHandling: class {
}

protocol TabBarCoordinator: class {
    func checkUnreadController()
    func hideUnreadController()
    func showUnreadController()
}
