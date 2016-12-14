//
//  NotificationConstants.swift
//  Mattermost
//
//  Created by iOS_Developer on 14.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

extension Notification.Name {
    static func newPost(inChannel channel:String) -> Notification.Name {
        return Notification.Name("newPostInChannel:" + channel)
    }
    
    static func newPost(inTeam team:String) -> Notification.Name {
        return Notification.Name("newPostInTeam:" + team)
    }
    
    static let updatedChanel = Notification.Name("channelUpdated")
}
