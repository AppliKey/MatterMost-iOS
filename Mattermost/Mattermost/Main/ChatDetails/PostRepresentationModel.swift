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
}
