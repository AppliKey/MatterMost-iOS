//
//  UIResponder+FirstResponder.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/2/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

private weak var currentFirstResponder: UIResponder?

extension UIResponder {
    
    static func firstResponder() -> UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    func findFirstResponder(_ sender: AnyObject) {
        currentFirstResponder = self
    }
    
}
