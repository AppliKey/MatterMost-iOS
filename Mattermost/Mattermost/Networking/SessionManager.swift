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
    
    //MARK: User
    var user: User? {
        get {
            return _user
        }
        set {
            _user = newValue
            service.user = newValue
        }
    }
    
    //MARK: Team
    var team: Team? {
        get {
            return _team
        }
        set {
            _team = newValue
            service.team = newValue
        }
    }
    
    //MARK: - Helpers
    
    var hasValidSession: Bool {
        return serverAddress != nil && token != nil && team != nil && user != nil
    }
    
    func clearCurrentSession() {
        team = nil
        user = nil
        serverAddress = nil
        token = nil
    }
    
    //MARK: - Private
    private lazy var _token: String? = self.service.savedToken()
    private lazy var _serverAddress: String? = self.service.savedServerAddress()
    private lazy var _user: User? = self.service.user
    private lazy var _team: Team? = self.service.team
    private var service = SessionService()
    
}
