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
    init(withRouter router: MainRouting, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        let tabBarViewController = UITabBarController()
        router.embed(centerViewController: tabBarViewController)
        tabBarViewController.viewControllers = setupTabBarViewControllers()
        NavigationManager.setRootController(router.rootController)
    }
    
    func showAuthorization() {
        NavigationManager.setRootController(appCoordinator.rootViewController())
    }
    
    //MARK: - Private -
    fileprivate let router: MainRouting
    fileprivate unowned let appCoordinator: AppCoordinator
    fileprivate let channelsService = ChannelsService()
    
    fileprivate func setupTabBarViewControllers() -> [UIViewController] {
        let favouritesNavigationController = createChatsNavigationController(withMode: .favourites)
        let publicChannelsNavigationController = createChatsNavigationController(withMode: .publicChats)
        let privateChannelsNavigationController = createChatsNavigationController(withMode: .privateChats)
        let directNavigationController = createChatsNavigationController(withMode: .direct)
        
        var tabBarControllers = [favouritesNavigationController, publicChannelsNavigationController,
                                 privateChannelsNavigationController, directNavigationController]
        
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController) == false {
            let unreadNavigationController = createChatsNavigationController(withMode: .unread)
            tabBarControllers.insert(unreadNavigationController, at: 0)
        }
        
        return tabBarControllers
    }
    
    fileprivate func createChatsNavigationController(withMode mode:ChatsMode) -> UINavigationController {
        guard let chats = R.storyboard.main.chats()
            else { fatalError("Can't instantiate chats view controller") }
        let navigationController = UINavigationController.init(rootViewController: chats)
        ChatsWireframe.setup(chats, withCoordinator: self, service: channelsService, mode: mode)
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
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController) {
            hideUnreadController()
        } else {
            showUnreadController()
        }
    }
    
    func hideUnreadController() {
        router.deleteFirstViewController()
    }
    
    func showUnreadController() {
        let unreadNavigationController = createChatsNavigationController(withMode: .unread)
        router.addViewController(unreadNavigationController)
    }
}

//MARK: - UnreadCoordinator
extension MainCoordinator : ChatsCoordinator {
    func openMenu() {
        router.toggleMenu()
    }
}
