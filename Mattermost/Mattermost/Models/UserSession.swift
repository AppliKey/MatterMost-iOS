//
//  UserSession.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

struct UserSession: DictionaryConvertible {
    
    let accessToken: String
    
    var dictionary: [String: AnyObject] {
        return [ "access_token" : accessToken as AnyObject ]
    }
}
