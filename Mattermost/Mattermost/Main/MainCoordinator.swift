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
    
    //TODO: Subclass tabBar for tabBar configuration
    func start() {
        let tabBarViewController = UITabBarController()
        router.sideMenu.embed(centerViewController: tabBarViewController)
        tabBarViewController.viewControllers = setupTabBarViewControllers()
        NavigationManager.setRootController(router.sideMenu)
    }
    
    //MARK: - Private -
    fileprivate let router: MainRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    
    //TODO: refactor
    fileprivate func setupTabBarViewControllers() -> [UIViewController] {
        let favouritesNavigationController = createChatsNavigationController(withMode: .favourites)
        let publicChannelsNavigationController = createChatsNavigationController(withMode: .publicChats)
        let privateChannelsNavigationController = createChatsNavigationController(withMode: .privateChats)
        let directNavigationController = createChatsNavigationController(withMode: .direct)
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController.rawValue) {
            return [favouritesNavigationController, publicChannelsNavigationController,
                    privateChannelsNavigationController, directNavigationController]
        } else {
            let unreadNavigationController = createChatsNavigationController(withMode: .unread)
            return [unreadNavigationController, favouritesNavigationController, publicChannelsNavigationController,
                    privateChannelsNavigationController, directNavigationController]
        }
    }
    
    func createChatsNavigationController(withMode mode:ChatsMode) -> UINavigationController {
        guard let chats = R.storyboard.main.chats()
            else { fatalError("Can't instantiate chats view controller") }
        let navigationController = UINavigationController.init(rootViewController: chats)
        ChatsWireframe.setup(chats, withCoordinator: self)
        switch mode {
        case .unread:
            chats.tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_unread_not_active(),
                                                         selectedImage: R.image.ic_unread())
        case .favourites:
            chats.tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_favorites_not_active(),
                                                         selectedImage: R.image.ic_favorites())
        case .publicChats:
            chats.tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_public_chanels_not_active(),
                                                         selectedImage: R.image.ic_public_chanels())
        case .privateChats:
            chats.tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_private_chanels_not_active(),
                                                         selectedImage: R.image.ic_private_chanels())
        case .direct:
            chats.tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_direct_not_active(),
                                                         selectedImage: R.image.ic_direct())
        }
        return navigationController
    }
    
    func checkTabBarControllers() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController.rawValue) {
            hideUnreadController()
        } else {
            showUnreadController()
        }
    }
    func hideUnreadController() {
        if let viewControllers = router.tabBarController.viewControllers, viewControllers.count == 5 {
            _ = router.tabBarController.viewControllers!.remove(at: 0)
        }
    }
    
    func showUnreadController() {
        if let viewControllers = router.tabBarController.viewControllers, viewControllers.count == 4 {
            let unreadNavigationController = createChatsNavigationController(withMode: .unread)
            router.tabBarController.viewControllers!.insert(unreadNavigationController, at: 0)
        }
    }
}

//MARK: - UnreadCoordinator
extension MainCoordinator : ChatsCoordinator {
    func openMenu() {
        router.sideMenu.toggle()
    }
}
