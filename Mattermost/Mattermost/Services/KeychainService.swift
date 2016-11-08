//
//  KeychainService.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Locksmith

class KeychainService {

    static func saveNetworkBaseUrl(baseUrl: URL) {
        if let _ = self.networkBaseUrl() {
            self.deleteNetworkBaseUrl()
        }
        do {
            try Locksmith.saveData(data: ["network_base_url": baseUrl], forUserAccount: Keychain.userAccountString)
        } catch let error {
            print("Failed to save user session: \(error)")
        }
    }

    private static func deleteNetworkBaseUrl() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: Keychain.userAccountString)
        } catch let error {
            print("Failed to delete user session: \(error)")
        }
    }

    static func networkBaseUrl() -> URL? {
        let data = Locksmith.loadDataForUserAccount(userAccount: Keychain.userAccountString)
        var session = self.sessionFromData(data: data)
        if data != nil && session == nil {
            deleteNetworkBaseUrl()
            session = nil
        }
        return session
    }

    private static func sessionFromData(data: [String: Any]?) -> URL? {
        guard let data = data,
              let baseUrl = data["network_base_url"] as? URL else { return nil }
        return baseUrl
    }
    
}
