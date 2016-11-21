//
//  GroupChatCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 18.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

fileprivate let defaultConstraintValue:CGFloat = 10.0

class GroupChatCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(R.nib.imageCollectionViewCell)
        collectionView.register(R.nib.labelCollectionViewCell)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Outlets
    @IBOutlet fileprivate weak var chatNameLabel: UILabel!
    @IBOutlet fileprivate weak var deliveryTimeLabel: UILabel!
    @IBOutlet fileprivate weak var lastMessageLabel: UILabel!
    
    @IBOutlet fileprivate weak var privateChannelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var privateChannelWidthConstraint: NSLayoutConstraint!
    
    var isPrivate: Bool = false {
        didSet {
            if oldValue != isPrivate {
                privateChannelLeadingConstraint.constant = isPrivate ? defaultConstraintValue : 0
                privateChannelWidthConstraint.constant = isPrivate ? defaultConstraintValue : 0
                
                layoutIfNeeded()
            }
        }
    }
    
    var imageUrls:[URL?]?
    
    func configure(forRepresentationModel model:ChatRepresentationModel) {
        chatNameLabel.text = model.chatName
        deliveryTimeLabel.text = model.deliveryTime
        lastMessageLabel.text = model.lastMessage
        isPrivate = model.isPrivateChannel
        imageUrls = model.avatarUrl
    }
    
}

extension GroupChatCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let usersCount:Int = imageUrls?.count ?? 0
        if indexPath.row < usersCount {
            if let avatarUrl = imageUrls?[indexPath.row] {
                if usersCount > 4 && indexPath.row == 4 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.labelCollectionViewCell, for: indexPath)!
                    cell.titleLabel.text = "+" + "\(usersCount - 3)"
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageCollectionViewCell, for: indexPath)!
                    cell.imageView.setRoundedImage(withUrl: avatarUrl)
                    return cell
                }
            } else {
                return getPlaceholderCell(collectionView, indexPath: indexPath)
            }
        } else {
            return getPlaceholderCell(collectionView, indexPath: indexPath)
        }
    }
    
    func getPlaceholderCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> ImageCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageCollectionViewCell, for: indexPath)!
        cell.imageView.image = R.image.placeholderSmall()
        return cell
    }
    
}
