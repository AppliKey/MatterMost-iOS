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
        guard let viewController = R.storyboard.main.tabBarViewController()
            else { fatalError("Can't instantiate server selection view controller") }
        TabBarWireframe.setup(viewController, withCoordinator: self)
        router.root(viewController: viewController)
    }
    
    //MARK: - Private -
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    
}

//MARK: - TabBarCoordinator
extension MainCoordinator: TabBarCoordinator {
    
}
