//
//  SignInTarget.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/21/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Unbox

struct SignInTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let email, password: String
    
    //MARK: - MattermostTarget -
    
    let path = "/users/login"
    let method = Moya.Method.post
    
    var parameters: [String : Any]? {
        return ["login_id": email, "password": password]
    }
    
    func map(_ response: Response) throws -> User {
        return try unbox(data: response.data) as User
    }
    
}

struct ResetPassTarget: MattermostTarget {
    //MARK: - Properties
    let email: String
    
    //MARK: - MattermostTarget -
    
    let path = "/users/send_password_reset"
    let method = Moya.Method.post
    
    var parameters: [String : Any]? {
        return ["email": email]
    }
}
