//
//  MyMessagesCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class MyMessagesCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.font = AppFonts.avenirNext()
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
}
