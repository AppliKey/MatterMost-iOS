//
//  SendPostTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 12.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct SendPostTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let teamId: String
    let channelId: String
    
    let message: String
    let userId: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/\(teamId)/channels/\(channelId)/posts/create"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        let dateStamp = Int(Date().timeIntervalSince1970)
        return ["filenames:": [],
                "message": message,
                "channel_id": channelId,
                "pending_post_id": "\(userId):\(dateStamp)",
                "user_id": userId,
                "create_at": dateStamp]
    }
    
    func map(_ response: Moya.Response) throws -> Post {
        return try unbox(data: response.data) as Post
    }

}
