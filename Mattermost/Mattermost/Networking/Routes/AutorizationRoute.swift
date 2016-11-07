//
//  AutorizationRoute
//
//
//  Created by torasike on 11/4/16.
//  Copyright © 2016 Applikey Solutions. All rights reserved.
//

import Foundation
import Alamofire

enum AutorizationRoute: APIRoute {
    
    case Login
    
    var path: String {
        switch self {
        case .Login(): return "users/login"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
}
