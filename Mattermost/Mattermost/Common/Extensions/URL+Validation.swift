//
//  URL+Validation.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

extension URL {
    
    static let defaultUrlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    
    func isValid(regex: String) -> Bool {
        let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return regexPredicate.evaluate(with: self.absoluteString)
    }
    
    
}
