//
//  Aliases.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

typealias VoidClosure = () -> ()

enum Result<T> {
    case success(T)
    case failure(String)
}

struct UserDefaultsKeys {
    static let hideUnreadController = "hideUnreadControllerKey"
}
