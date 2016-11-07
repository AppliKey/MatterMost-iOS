//
//  UINavigationBar+Shadow.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func clearShadow() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
    
}
