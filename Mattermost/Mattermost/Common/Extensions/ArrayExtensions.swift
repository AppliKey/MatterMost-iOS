//
//  ArrayExtensions.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/27/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
}
