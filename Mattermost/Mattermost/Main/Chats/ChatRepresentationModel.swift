//
//  ChatsViewModel.swift
//  Mattermost
//
//  Created by iOS_Developer on 18.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class ChatRepresentationModel {
    var isDirectChat = false
    
    var avatarUrl: [URL?]?
    var chatName: String = String()
    var deliveryTime: String = String()
    var lastMessage: String = String()
    var isUnread: Bool = false
    var onlineStatusColor:UIColor = UIColor.clear
    
    var peopleCount = 1
    var isPrivateChannel = false
}
