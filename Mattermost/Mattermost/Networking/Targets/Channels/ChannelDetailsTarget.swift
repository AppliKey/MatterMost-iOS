//
//  ChannelDetailsTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 23.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct ChannelDetailsTarget : MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let teamId: String
    let channelId: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/" + teamId + "/channels/" + channelId + "/extra_info"
    }
    
    func map(_ response: Moya.Response) throws -> ChannelDetails {
        return try unbox(data: response.data) as ChannelDetails
    }    
}
