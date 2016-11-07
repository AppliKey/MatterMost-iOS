//
//  MainCoordinator.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
    
    //MARK: - Init
    init(withRouter router: MainRouter, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        guard let tabBarViewController = R.storyboard.main.tabBarViewController()
            else { fatalError("Can't instantiate tab bar view controller") }
        TabBarWireframe.setup(tabBarViewController, withCoordinator: self)
        router.root(viewController: tabBarViewController)
    }
    
    //MARK: - Private -
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    
}

//MARK: - TabBarCoordinator
extension MainCoordinator: TabBarCoordinator {
    func showSettings() {
        guard let menu = R.storyboard.main.menuViewController()
            else { fatalError("Can't instantiate settings view controller") }
        router.leftToRightPush(viewController: menu)
    }
}
