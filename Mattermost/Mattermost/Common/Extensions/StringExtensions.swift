//
//  StringExtensions.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    var separatedWithSpaces: String {
        var result = ""
        for character in self.characters {
            result.append(character)
            result.append(" ")
        }
        return result
    }
    
}
