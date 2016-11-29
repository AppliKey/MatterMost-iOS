//
//  ChannelDetails.swift
//  Mattermost
//
//  Created by iOS_Developer on 23.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

struct ChannelDetails {
    var channelId: String
    var members: [User]
    var membersCount: Int
}

extension ChannelDetails : Unboxable {
    init(unboxer: Unboxer) throws {
        channelId = try unboxer.unbox(key: "id")
        members = try unboxer.unbox(key: "members")
        membersCount = try unboxer.unbox(key: "member_count")
    }
}
