//
//  Fonts.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

struct AppFonts {
    static func avenirNext(_ size:CGFloat = 16) -> UIFont {
        guard let font = UIFont(name: "AvenirNext-Regular", size: size)
            else { fatalError("Can not create font Avenir-Next") }
        
        return font
    }
}
