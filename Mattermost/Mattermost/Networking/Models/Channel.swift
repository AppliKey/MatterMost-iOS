//
//  Channel.swift
//  Mattermost
//
//  Created by iOS_Developer on 22.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Unbox

struct Channel {
    var channelId: String
    var createdAt: Date
    var updatedAt: Date
    var deletedAt: Date
    var teamId: String
    var type: String
    var displayName: String
    var name: String
    var header: String
    var purpose: String
    var lastPostAt: Date
    var totalMsgCount: Int
    var extraUpdateAt: Date
    var creatorId: String
}

extension Channel : Unboxable {
    init(unboxer: Unboxer) throws {
        channelId = try unboxer.unbox(key: "id")
        createdAt = Date(timeIntervalSince1970:(try unboxer.unbox(key: "create_at")))
        updatedAt = Date(timeIntervalSince1970:(try unboxer.unbox(key: "update_at")))
        deletedAt = Date(timeIntervalSince1970:(try unboxer.unbox(key: "delete_at")))
        teamId = try unboxer.unbox(key: "team_id")
        type = try unboxer.unbox(key: "type")
        displayName = try unboxer.unbox(key: "display_name")
        name = try unboxer.unbox(key: "name")
        header = try unboxer.unbox(key: "header")
        purpose = try unboxer.unbox(key: "purpose")
        lastPostAt = Date(timeIntervalSince1970:(try unboxer.unbox(key: "last_post_at")))
        totalMsgCount = try unboxer.unbox(key: "total_msg_count")
        extraUpdateAt = Date(timeIntervalSince1970:(try unboxer.unbox(key: "extra_update_at")))
        creatorId = try unboxer.unbox(key: "creator_id")
    }
}
