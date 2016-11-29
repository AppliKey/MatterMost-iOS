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
        let modifier = AnyModifier { request in
            var r = request
            let token = SessionManager.shared.token
            r.setValue(token, forHTTPHeaderField: "Authorization")
            return r
        }
        self.kf.setImage(with: url, options: [ .requestModifier(modifier)])
    }
    
    func setRoundedImage(withUrl url:URL?) {
        guard let url = url else {
            return
        }
        self.kf.indicatorType = .activity
        let modifier = AnyModifier { request in
            var r = request
            let token = SessionManager.shared.token
            r.setValue(token, forHTTPHeaderField: "Authorization")
            return r
        }
        self.kf.setImage(with: url, options: [.requestModifier(modifier)],
                         completionHandler:  { (image, error, cacheType, imageURL) in
            guard let image = image else {return}
            let imageWidth = image.size.width
            self.image = image.kf.image(withRoundRadius: imageWidth / 2, fit: image.size, scale: 1)
        })
    }
}
