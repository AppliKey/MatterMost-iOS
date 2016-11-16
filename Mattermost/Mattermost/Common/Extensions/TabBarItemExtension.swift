//
//  TabBarItemExtension.swift
//  Mattermost
//
//  Created by iOS_Developer on 11.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

extension UITabBarItem {
    class func withoutTitle(image:UIImage?, selectedImage:UIImage?) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return tabBarItem
    }
}
