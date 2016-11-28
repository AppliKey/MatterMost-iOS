//
//  User.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

enum OnlineStatus: String, UnboxableEnum {
    case online = "online"
    case offline = "offline"
    case away = "away"
}

struct User {
    let id: String
    let username: String
    let email: String?
    let nickname: String?
    let firstname: String?
    let lastname: String?
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        username = try unboxer.unbox(key: "username")
        email = unboxer.unbox(key: "email")
        nickname = unboxer.unbox(key: "nickname")
        firstname = unboxer.unbox(key: "first_name")
        lastname = unboxer.unbox(key: "last_name")
    }
}
