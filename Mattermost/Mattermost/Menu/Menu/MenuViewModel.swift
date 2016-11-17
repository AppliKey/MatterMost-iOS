//
//  MenuViewModel.swift
//  Mattermost
//
//  Created by iOS_Developer on 11.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class MenuViewModel {
    var menuItems = [R.string.localizable.menuItemChannels(),
                     R.string.localizable.menuItemInvite(),
                     R.string.localizable.menuItemSettings()]
    
    var itemsCount:Int {
        return menuItems.count
    }
    
}
