    //
//  UserSession.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import KeychainAccess

struct SessionService {
    
    //MARK: - Token
    
    func savedToken() -> String? {
        return keychain[tokenKey]
    }
    
    func saveToken(_ token: String) {
        save(token, forKey: tokenKey)
    }
    
    func deleteToken() {
        keychain[tokenKey] = nil
    }
    
    //MARK: - Server address
    
    func savedServerAddress() -> String? {
        return keychain[serverAddressKey]
    }
    
    func saveServerAddress(_ address: String) {
        save(address, forKey: serverAddressKey)
    }
    
    func deleteServerAddress() {
        keychain[serverAddressKey] = nil
    }
    
    //MARK: - Private 
    fileprivate let tokenKey = "access_token"
    fileprivate let serverAddressKey = "server_address"
    fileprivate let keychain = Keychain(service: "com.Mattermost.Session")
    
    fileprivate func save(_ string: String, forKey key: String) {
        do {
            try keychain.set(string, key: key)
        } catch let error {
            print("Failed to save user session: \(error)")
        }
    }
    
}
