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
    var serverVersion: String?
    
    //MARK: - Token
    var token: String? {
        get {
            return _token
        }
        set {
            _token = newValue
            if let token = newValue {
                service.saveToken(token)
            } else {
                service.deleteToken()
            }
        }
    }
    
    //MARK: - Server address
    var serverAddress: String? {
        get {
            return _serverAddress
        }
        set {
            _serverAddress = newValue
            if let address = newValue {
                service.saveServerAddress(address)
            } else {
                service.deleteServerAddress()
            }
        }
    }
    
    //MARK: - Helpers
    
    var hasValidSession: Bool {
        return serverAddress != nil && token != nil && team != nil
    }
    
    //MARK: - Private
    private lazy var _token: String? = self.service.savedToken()
    private lazy var _serverAddress: String? = self.service.savedServerAddress()
    private let service = SessionService()
    
}
