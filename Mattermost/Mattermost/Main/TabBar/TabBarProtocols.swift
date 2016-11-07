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
    func checkUnreadController()
}

protocol TabBarPresenting: class {
    var tabBarViewControllers: [UIViewController]? { get set }
}

protocol TabBarViewing: class {
    var tabBarViewControllers: [UIViewController]? { get set }
}

protocol TabBarEventHandling: class {
    func viewIsReady()
}

protocol TabBarCoordinator: class {
    func showSettings()
}
