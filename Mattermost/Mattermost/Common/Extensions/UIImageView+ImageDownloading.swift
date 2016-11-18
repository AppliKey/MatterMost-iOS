//
//  UIImageView+ImageDownloading.swift
//  Mattermost
//
//  Created by iOS_Developer on 18.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(withUrl url:URL?) {
        guard let url = url else {
            return
        }
        self.kf.setImage(with: url)
    }
}
