//
//  SingleChatCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 18.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Kingfisher

fileprivate let defaultConstraintValue:CGFloat = 10.0

class SingleChatCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Private Outlets
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var deliveryTimeLabel: UILabel!
    @IBOutlet fileprivate weak var lastMessageLabel: UILabel!
    
    @IBOutlet fileprivate weak var unreadStatusLeadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var unreadStatusWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var userOnlineStatusView: UIView!
    
    //MARK: - Public Properties
    var userName: String? {
        get {return userNameLabel.text}
        set {userNameLabel.text = newValue}
    }
    
    var lastMessage: String? {
        get {return lastMessageLabel.text}
        set {lastMessageLabel.text = newValue}
    }
    
    var deliveryTime: String? {
        get {return deliveryTimeLabel.text}
        set {deliveryTimeLabel.text = newValue}
    }
    
    var isUnread: Bool = false {
        didSet {
            if oldValue != isUnread {
                unreadStatusLeadingConstraint.constant = isUnread ? defaultConstraintValue : 0
                unreadStatusWidthConstraint.constant = isUnread ? defaultConstraintValue : 0
                
                userOnlineStatusView.layer.borderColor = isUnread ? UIColor(rgba: "#f4f5f7").cgColor : UIColor.white.cgColor
                
                layoutIfNeeded()
            }
        }
    }
    
    var onlineStatusColor: UIColor = UIColor.clear {
        didSet {
            if oldValue != onlineStatusColor {
                userOnlineStatusView.backgroundColor = onlineStatusColor
            }
        }
    }
}
