//
//  AllUsersTarget.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/26/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Unbox

struct AllUsersTarget: MattermostTarget, ResponseMapping {
    
    let teamId: String
    
    init(teamId: String) {
        self.teamId = teamId
    }
    
    //MARK: - MattermostTarget
    
    var path: String {
        return "/users/profiles/\(teamId)"
    }
    
    //MARK: - ResponseMapping
    
    func map(_ response: Moya.Response) throws -> [User] {
        if let json = try response.mapJSON() as? UnboxableDictionary {
            var users: [User] = []
            for key in json.keys {
                if let user = try? unbox(dictionary: json, atKey: key) as User {
                    users.append(user)
                }
            }
            return users
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
    
}
