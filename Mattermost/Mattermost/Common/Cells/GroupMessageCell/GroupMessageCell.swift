//
//  GroupMessageCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 09.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class GroupMessageCell: BaseChatMessageCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let path = UIBezierPath(roundedRect: userOnlineStatusView.bounds,
                                cornerRadius: userOnlineStatusView.bounds.width / 2)
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = userOnlineStatusView.bounds
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.strokeColor = UIColor(rgba: "#f2f3f6").cgColor
        shapeLayer.lineWidth = 4
        userOnlineStatusView.layer.addSublayer(shapeLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
        onlineStatus = .offline
    }
    
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var userOnlineStatusView: UIView!
    
    fileprivate var shapeLayer:CAShapeLayer!
    
    var onlineStatus: OnlineStatus = .offline {
        didSet {
            switch onlineStatus {
            case .online:
                shapeLayer.fillColor = UIColor.green.cgColor
            case .away:
                shapeLayer.fillColor = UIColor.yellow.cgColor
            default:
                shapeLayer.fillColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    override func configure(withRepresentationModel model: PostRepresentationModel) {
        super.configure(withRepresentationModel: model)
        
        userNameLabel.text = model.userName
        if let userOnlineStatus = model.userOnlineStatus {
            onlineStatus = userOnlineStatus
        }
        if let avatarUrl = model.userAvatarUrl {
            avatarImageView.setRoundedImage(withUrl: avatarUrl)
        } else {
            avatarImageView.image = nil
        }
    }
    
}
