    //
//  UserSession.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import KeychainAccess
import Unbox

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
    
    // MARK - User
    
    var user:User? {
        get {
            if let userId = UserDefaults.standard.value(forKey: UserDefaultsKeys.userId) as? String,
                let userName = UserDefaults.standard.value(forKey: UserDefaultsKeys.userName) as? String {
                return User(id: userId, username: userName, email: nil, nickname: nil, firstname: nil, lastname: nil)
            } else {
                return nil
            }
        } set {
            UserDefaults.standard.set(newValue?.id, forKey: UserDefaultsKeys.userId)
            UserDefaults.standard.set(newValue?.username, forKey: UserDefaultsKeys.userName)
        }
    }
    
    // MARK - Team 
    
    var team: Team? {
        get {
            if let teamId = UserDefaults.standard.value(forKey: UserDefaultsKeys.teamId) as? String,
                let teamName = UserDefaults.standard.value(forKey: UserDefaultsKeys.teamName) as? String {
                return Team(id: teamId, name: teamName, displayName: teamName)
            } else {
                return nil
            }
        } set {
            UserDefaults.standard.set(newValue?.id, forKey: UserDefaultsKeys.teamId)
            UserDefaults.standard.set(newValue?.displayName, forKey: UserDefaultsKeys.teamName)
        }
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
