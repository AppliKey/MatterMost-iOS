//
//  PostRepresentationModel.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

struct PostRepresentationModel {
    var userName: String?
    var userAvatarUrl: URL?
    var message: String?
    var date: Date?
    var topViewText: String?
    var isMyMessage: Bool
    var showAvatar: Bool
    var showTopView: Bool
    var showBottomView: Bool
    var isUnread: Bool
}
