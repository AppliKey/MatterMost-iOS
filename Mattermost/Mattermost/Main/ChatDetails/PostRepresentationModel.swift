//
//  PostRepresentationModel.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

struct PostRepresentationModel {
    
    enum PostStatus {
        case sending, sended, failed
    }
    
    var userName: String?
    var userAvatarUrl: URL?
    var userOnlineStatus: OnlineStatus?
    var isDirectChat = true
    var message: String?
    var date: Date?
    var topViewText: String? = nil
    var isMyMessage: Bool
    var showAvatar: Bool = true
    var showTopView: Bool = true
    var showBottomView: Bool = true
    var isUnread: Bool
    var postStatus: PostStatus?
    var postId:String?
    var replyMessageId: String?
    
    var placeholderId:String?
    
    static func showBottomView(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if let date = post.date, let previousDate = previousPost.date, post.userAvatarUrl == previousPost.userAvatarUrl {
            if DateHelper.fullDateTimeString(forDate: date) == DateHelper.fullDateTimeString(forDate: previousDate) {
                return false
            }
        }
        return true
    }
    
    static func showTopView(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if let date = post.date, let previousDate = previousPost.date, !post.isUnread, !previousPost.isUnread {
            if DateHelper.prettyDateString(forDate: date) == DateHelper.prettyDateString(forDate: previousDate) {
                return false
            }
        }
        if post.isUnread && previousPost.isUnread {
            return false
        }
        return true
    }
    
    static func showAvatar(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if post.isMyMessage {
            return false
        }
        if post.userAvatarUrl == previousPost.userAvatarUrl {
            return post.showTopView
        }
        return true
    }
}
