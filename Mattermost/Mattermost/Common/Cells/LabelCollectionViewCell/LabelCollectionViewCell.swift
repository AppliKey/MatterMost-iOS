//
//  LabelCollectionViewCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 21.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}
