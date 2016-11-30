//
//  SettingsSettingsInteractor.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SettingsInteractor {
  	weak var presenter: SettingsPresenting!
}

extension SettingsInteractor: SettingsInteracting {
    
    var hideUnreadController: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.hideUnreadController)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.hideUnreadController)
        }
    }
    
}
