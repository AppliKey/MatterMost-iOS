//
//  GroupMemberCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/27/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell, NibReusable {
    
    func configure(with user: UserRepresantation) {
        userNameLabel.text = user.name
        avatarImageView.setRoundedImage(withUrl: user.avatarURL)
    }
    
    //MARK: - Outlets
    
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var selectionButton: UIButton!
    
    //MARK: - Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil
    }
    
}
