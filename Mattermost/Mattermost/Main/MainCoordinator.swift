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
        
        tabBarViewController.viewControllers = setupTabBarViewControllers()
        NavigationManager.setRootController(tabBarViewController)
    }
    
    //MARK: - Private -
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    
    fileprivate func setupTabBarViewControllers() -> [UIViewController] {
        guard let unreadController = R.storyboard.main.unreadViewController()
            else { fatalError("Can't instantiate unread view controller") }
        let unreadNavigationController = UINavigationController.init(rootViewController: unreadController)
        UnreadWireframe.setup(unreadController, withCoordinator: self)
        unreadController.tabBarItem = UITabBarItem(title: nil,
                                                   image: R.image.ic_unread_not_active(),
                                                   selectedImage: R.image.ic_unread())
        
        guard let favouritesController = R.storyboard.main.favouritesViewController()
            else { fatalError("Can't instantiate favourites view controller") }
        favouritesController.tabBarItem = UITabBarItem(title: nil,
                                                       image: R.image.ic_favorites_not_active(),
                                                       selectedImage: R.image.ic_favorites())
        let favouritesNavigationController = UINavigationController(rootViewController: favouritesController)
        
        guard let publicChannelsController = R.storyboard.main.publicChanelsViewController()
            else { fatalError("Can't instantiate public channels view controller") }
        publicChannelsController.tabBarItem = UITabBarItem(title: nil,
                                                       image: R.image.ic_public_chanels_not_active(),
                                                       selectedImage: R.image.ic_public_chanels())
        let publicChannelsNavigationController = UINavigationController(rootViewController: publicChannelsController)
        
        return [unreadNavigationController, favouritesNavigationController, publicChannelsNavigationController]
    }
    
}

//MARK: - TabBarCoordinator
extension MainCoordinator: TabBarCoordinator {
}

//MARK: - UnreadCoordinator
extension MainCoordinator : UnreadCoordinator {
    func openMenu(fromViewController viewController: UIViewController) {
        guard let menu = R.storyboard.main.menuViewController()
            else { fatalError("Can't instantiate settings view controller") }
        MenuWireframe.setup(menu, withCoordinator: self)
        router.pushFromLeft(fromViewController: viewController, to: menu)
    }
}

extension MainCoordinator : MenuCoordinator {
    func goBack(fromViewController viewController: UIViewController) {
        router.popToRight(fromViewController: viewController)
    }
}
