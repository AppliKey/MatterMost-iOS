//
//  TabBarTabBarInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

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
            presenter.hideUnreadController()
        } else {
            presenter.showUnreadController()
        }
    }    
}

extension TabBarInteractor: TabBarInteracting {
    
    func checkUnreadController() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController) {
            presenter.hideUnreadController()
        } else {
            presenter.showUnreadController()
        }
    }
}
