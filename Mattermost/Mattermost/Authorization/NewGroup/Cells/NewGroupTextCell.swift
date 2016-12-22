//
//  NewGroupTextCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/21/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class NewGroupTextCell: UITableViewCell, NibReusable {

    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: RSKPlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTextView()
    }
    
    //MARK: - Private -
    
    private func configureTextView() {
        textView.textContainerInset = UIEdgeInsets.zero
    }
    
}
