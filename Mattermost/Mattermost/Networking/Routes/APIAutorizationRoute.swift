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
    
    case Login(email: String, password: String)
    
    var path: String {
        switch self {
        case .Login(_,_): return "users/login"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .Login(let email, let password):
            return ["email": email, "password": password]
        }
    }
    
}
