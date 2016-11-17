//
//  SettingsSettingsProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsConfigurator: class {
    
}

protocol SettingsInteracting: class {
    var hideUnreadController: Bool { get set }
}

protocol SettingsPresenting: class {
}

protocol SettingsViewing: class {
    func setUnreadSwitcher(withValue value:Bool)
}

protocol SettingsEventHandling: class {
    func handleSwitcherValueChanged(_ value:Bool)
    func viewWillDissapear()
    func viewIsReady()
    func handleEditProfile()
    func handleLogout()
}

protocol SettingsCoordinator: class {
    func checkTabBarControllers()
}
