//
//  MyMessagesCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class MyMessagesCell: BaseChatMessageCell {
    
    @IBOutlet private weak var leftView: UIView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var retryButton: UIButton!
    
    @IBAction private func retryPressed(_ sender: Any) {
        retryCallback?()
    }
    
    var retryCallback: VoidClosure?
    
    var postStatus: PostRepresentationModel.PostStatus? {
        didSet {
            if let status = postStatus {
                switch status {
                case .sending:
                    leftView.isHidden = false
                    activityIndicatorView.isHidden = false
                    retryButton.isHidden = true
                case .failed:
                    leftView.isHidden = false
                    activityIndicatorView.isHidden = true
                    retryButton.isHidden = false
                default:
                    leftView.isHidden = true
                }
            } else {
                leftView.isHidden = true
            }
        }
    }
    
}
