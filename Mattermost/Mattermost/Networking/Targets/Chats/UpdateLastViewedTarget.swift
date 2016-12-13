//
//  UpdateLastViewedTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 13.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Moya
import Result
import Unbox
import Alamofire

struct UpdateLastViewedTarget: MattermostTarget, ResponseMapping {
    //MARK: - Properties
    let teamId: String
    let channelId: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/\(teamId)/channels/\(channelId)/update_last_viewed_at"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    func map(_ response: Moya.Response) throws -> UnboxableDictionary? {
        return try response.mapJSON() as? UnboxableDictionary
    }
}
