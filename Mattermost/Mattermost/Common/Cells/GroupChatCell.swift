//
//  GroupChatCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 18.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class GroupChatCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Outlets
    @IBOutlet fileprivate weak var chatNameLabel: UILabel!
    @IBOutlet fileprivate weak var deliveryTimeLabel: UILabel!
    @IBOutlet fileprivate weak var lastMessageLabel: UILabel!
    
    @IBOutlet fileprivate weak var privateChannelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var privateChannelWidthConstraint: NSLayoutConstraint!
    
    
    
}

extension GroupChatCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
}
