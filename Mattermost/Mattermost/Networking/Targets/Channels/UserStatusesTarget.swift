//
//  UserStatusesTarget.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/28/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox
import Alamofire

struct UserStatusesTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let userIds: [String]
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/users/status"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        return ["jsonArray": userIds]
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return ArrayParameterEncoding()
    }
    
    func map(_ response: Moya.Response) throws -> [String : OnlineStatus] {
        if let json = try response.mapJSON() as? UnboxableDictionary {
            var statuses = [String : OnlineStatus]()
            for key in json.keys {
                if let status = try? OnlineStatus.unbox(value: json[key] ?? "offline", allowInvalidCollectionElements: false) {
                    statuses[key] = status
                }
            }
            return statuses
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}
