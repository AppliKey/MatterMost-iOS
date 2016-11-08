//
//  APIAutorizationRoute
//
//
//  Created by torasike on 11/4/16.
//  Copyright © 2016 Applikey Solutions. All rights reserved.
//

import Foundation
import Alamofire

enum APIAutorizationRoute: APIRoute {
    
    case Ping
    case Login(email: String, password: String)
    
    var path: String {
        switch self {
        case .Login(_,_): return "users/login"
        case .Ping: return "general/ping"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Login(_,_): return .post
        case .Ping: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .Login(let email, let password):
            return ["email": email, "password": password]
        default: return nil
        }
    }
    
}
