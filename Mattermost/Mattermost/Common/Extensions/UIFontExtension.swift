//
//  UIFontExtension.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/22/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

extension UIFont {
    
    @objc(mtm_mainFontOfSize:)
    class func mainFontOfSize(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "AvenirNext-Regular", size: size)
            else { fatalError("Can not create font Avenir-Next") }
        return font
    }
    
    @objc(mtm_mediumFontOfSize:)
    class func mediumFontOfSize(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "AvenirNext-Medium", size: size)
            else { fatalError("Can not create font Avenir-Next") }
        return font
    }
    
}
