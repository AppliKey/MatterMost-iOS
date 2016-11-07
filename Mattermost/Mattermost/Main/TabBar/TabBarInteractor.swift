//
//  TabBarTabBarInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let unreadControllerSettingChanged = Notification.Name("unreadControllerSettingChanged")
}

class TabBarInteractor {
  	weak var presenter: TabBarPresenting!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUnreadControllerSettingChanged),
                                               name: .unreadControllerSettingChanged, object: nil)
        //TODO: Notification observers for badge add here
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleUnreadControllerSettingChanged(hideUnreadController:Bool) {
        if hideUnreadController {
            self.hideUnreadController()
        } else {
            self.showUnreadController()
        }
    }
    
    fileprivate func hideUnreadController() {
        if let viewControllers = presenter.tabBarViewControllers, viewControllers.count == 5 {
            _ = presenter.tabBarViewControllers!.remove(at: 0)
        }
    }
    
    fileprivate func showUnreadController() {
        if let viewControllers = presenter.tabBarViewControllers, viewControllers.count == 4 {
            guard let unreadViewController = R.storyboard.main.unreadMessagesViewController()
                else { fatalError("Can't instantiate unread view controller") }
            presenter.tabBarViewControllers!.insert(unreadViewController, at: 0)
        }
    }
}

extension TabBarInteractor: TabBarInteracting {
    
    func checkUnreadController() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController) {
            hideUnreadController()
        } else {
            showUnreadController()
        }
    }
}
