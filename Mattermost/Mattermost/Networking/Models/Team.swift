//
//  Team.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

struct Team {
    var id: String
    var name: String
    var displayName: String
}

extension Team: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        displayName = try unboxer.unbox(key: "display_name")
    }
}
