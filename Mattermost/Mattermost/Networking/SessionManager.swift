//
//  SessionManager.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/13/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SessionManager {
    //MARK: - Shared
    static let shared = SessionManager()
    
    //MARK: - Properties
    var user: User?
    var team: Team?
    var serverAddress: String? = "http://54.234.249.244"
    var serverVersion: String?
    var token: String?
    
}
