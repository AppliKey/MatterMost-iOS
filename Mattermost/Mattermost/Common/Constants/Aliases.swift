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

struct UserDefaultsKeys {
    static let hideUnreadController = "hideUnreadControllerKey"
    static let userName = "user.nickname"
    static let userId = "user.id"
    static let teamName = "team.name"
    static let teamId = "team.id"
}
