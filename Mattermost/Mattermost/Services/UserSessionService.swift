//
//  UserSession.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Locksmith

struct UserSessionService {
        
    static func save(session: UserSession) {
        if let _ = self.authorizedSession() {
            self.deleteSession()
        }
        do {
            try Locksmith.saveData(data: session.dictionary, forUserAccount: Keychain.userAccountString)
        } catch let error {
            print("Failed to save user session: \(error)")
        }
    }
    
    static func deleteSession() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: Keychain.userAccountString)
        } catch let error {
            print("Failed to delete user session: \(error)")
        }
    }
    
    /**
     - returns: Saved user session if app was not reinstalled and
     session data can be represented as UserSession object
     */
    static func authorizedSession() -> UserSession? {
        let data = Locksmith.loadDataForUserAccount(userAccount: Keychain.userAccountString)
        var session = self.sessionFromData(data: data)
        if data != nil && session == nil {
            deleteSession()
            session = nil
        }
        return session
    }
    
    private static func sessionFromData(data: [String: Any]?) -> UserSession? {
        guard let data = data,
            let accessToken = data["access_token"] as? String,
            !accessToken.isEmpty else { return nil }
        return UserSession(accessToken: accessToken)
    }
    
}
