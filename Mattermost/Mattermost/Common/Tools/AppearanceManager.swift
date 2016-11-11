//
//  AppearanceManager.swift
//  Mattermost
//
//  Created by iOS_Developer on 11.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class AppearanceManager {

    class func setupDefaultAppearance() {
        setupNavigationbarAppearance()
    }
    
    private class func setupNavigationbarAppearance() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = .white
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        let backButtonInsets = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 0)
        let backButtonImage = R.image.back()?
            .withRenderingMode(.alwaysOriginal)
            .withAlignmentRectInsets(backButtonInsets)
        navBar.backIndicatorImage = backButtonImage
        navBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
}
