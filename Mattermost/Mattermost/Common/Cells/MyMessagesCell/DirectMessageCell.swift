//
//  DirectMessageCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 09.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

private let leadingMarginInGroupChats: CGFloat = 72
private let leadingMarginInDirectChats: CGFloat = 20

class DirectMessageCell: BaseChatMessageCell {
    
    @IBOutlet weak var directMessageLeadingConstraint: NSLayoutConstraint!
    
    var isDirectChat:Bool = true {
        didSet {
            directMessageLeadingConstraint.constant = isDirectChat ? leadingMarginInDirectChats : leadingMarginInGroupChats
        }
    }
    
    override func configure(withRepresentationModel model: PostRepresentationModel) {
        super.configure(withRepresentationModel: model)
        isDirectChat = model.isDirectChat
    }
}
