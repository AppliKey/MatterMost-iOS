//
//  HeightProcessor.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class HeightProcessor {
    var cachedHeight = Dictionary<Int, CGFloat>()
    
    func getheight(forString text:String, withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let cacheKey:Int = text.hash + Int(width)
        if let cachedValue = cachedHeight[cacheKey] {
            return cachedValue
        } else {
            let height = ceil(text.height(withConstrainedWidth: width, font: font))
            cachedHeight[cacheKey] = height
            return height
        }
    }
}
