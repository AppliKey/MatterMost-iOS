//
//  Post.swift
//  Mattermost
//
//  Created by iOS_Developer on 24.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

class Post : Unboxable {
    var id: String
    var createDate: Date
    var updateDate: Date?
    var deleteDate: Date?
    var userId: String
    var channelId: String?
    var rootId: String?
    var parentId: String?
    var originalId: String?
    var message: String?
    var type: String?
    var hashtag: String?
    var filenames: [String]?
    var pendingPostId: String?
    
    var replyedMessage: String?
    var isVisible = true
    var isUnread = false
    var user: User?
    
    required init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        createDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "create_at")) / 1000)
        updateDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "update_at")) / 1000)
        deleteDate =  Date(timeIntervalSince1970:(try unboxer.unbox(key: "delete_at")) / 1000)
        userId = try unboxer.unbox(key: "user_id")
        channelId = unboxer.unbox(key: "channel_id")
        rootId = unboxer.unbox(key: "root_id")
        parentId = unboxer.unbox(key: "parent_id")
        originalId = unboxer.unbox(key: "original_id")
        message = unboxer.unbox(key: "message")
        type = unboxer.unbox(key: "type")
        hashtag = unboxer.unbox(key: "hashtag")
        filenames = unboxer.unbox(key: "filenames")
        pendingPostId = unboxer.unbox(key: "pending_post_id")
    }
}
