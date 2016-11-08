//
//  AuthorizationService.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class AuthorizationService{
    weak var manager = NetworkManager.shared
}

extension AuthorizationService: SignInService {
    
    func signIn(withEmail email: String, password: String, completion: (Result<Void>) -> Void) {
        
        //TODO: Network request
    }
}

extension AuthorizationService: ServerPingProtocol {
    
    func pingServer(url: URL, completion: @escaping ServerPingClosure) -> () {
        manager?.baseURL = url
        manager?.performRequest(route: APIAutorizationRoute.Ping, mapping:objectMapperMapping(), completion: completion)
    }
    
}
