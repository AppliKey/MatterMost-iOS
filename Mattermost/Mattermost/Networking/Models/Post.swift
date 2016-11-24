//
//  Post.swift
//  Mattermost
//
//  Created by iOS_Developer on 24.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

struct Post {
    var id: String
    var createDate: Date
    var updateDate: Date
    var deleteDate: Date
    var userId: String
    var channelId: String
    var rootId: String
    var parentId: String
    var originalId: String
    var message: String
    var type: String
    var hashtag: String
    var filenames: [String]
    var pendingPostId: String
}

extension Post: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        createDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "create_at")) / 1000)
        updateDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "update_at")) / 1000)
        deleteDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "delete_at")) / 1000)
        userId = try unboxer.unbox(key: "user_id")
        channelId = try unboxer.unbox(key: "channel_id")
        rootId = try unboxer.unbox(key: "root_id")
        parentId = try unboxer.unbox(key: "parent_id")
        originalId = try unboxer.unbox(key: "original_id")
        message = try unboxer.unbox(key: "message")
        type = try unboxer.unbox(key: "type")
        hashtag = try unboxer.unbox(key: "hashtag")
        filenames = try unboxer.unbox(key: "filenames")
        pendingPostId = try unboxer.unbox(key: "pending_post_id")
    }
}
