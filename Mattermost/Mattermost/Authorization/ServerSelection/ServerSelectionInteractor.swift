//
//  ServerSelectionServerSelectionInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

protocol ServerPingProtocol {
    func pingServer(url: URL, completion: @escaping ServerPingClosure)
}

class ServerSelectionInteractor {
    weak var presenter: ServerSelectionPresenting!
    var serverService:ServerPingProtocol  = AuthorizationService()
}

extension ServerSelectionInteractor: ServerSelectionInteracting {
    
    func isAddressValid(address: String, completion: @escaping (_ isValid: Bool, _ message: String?) -> () ) {
        guard let url = URL(string: address) else { return completion(false, "Address is not valid") }
        guard (url.isValid(regex: URL.validIpAddressRegex) ||
            url.isValid(regex: URL.validHostnameRegex) ||
            url.isValid(regex: URL.validHttpIpAddressRegex)) else {
            return completion(false, "Address format is not valid")
        }
        
        serverService.pingServer(url: url) { (result) in
            switch result {
            case .success(_):
                completion(true, "Valid")
            case .failure( _):
                completion(false, "Wrong server address")
            }
        }
    }
    
}
