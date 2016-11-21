//
//  Aliases.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Result

typealias VoidClosure = () -> ()

enum UserDefaultsKeys : String {
    case hideUnreadController = "hideUnreadControllerKey"
}
