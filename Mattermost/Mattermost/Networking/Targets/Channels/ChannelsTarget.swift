//
//  ChannelsTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 22.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct ChannelsTarget: MattermostTarget, ResponseMapping {

    //MARK: - Properties
    let teamId: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/" + teamId + "/channels/"
    }
    
    func map(_ response: Moya.Response) throws -> [Channel] {
        if let json = try response.mapJSON() as? UnboxableDictionary {
            let channels = try unbox(dictionary: json, atKey: "channels") as [Channel]
            let membersDict = json["members"] as? UnboxableDictionary
            
            for channel in channels {
                let member = membersDict?[channel.channelId] as? UnboxableDictionary
                if let lastViewedTimeStamp = member?["last_viewed_at"] as? TimeInterval {
                    let lastViewedDate = Date(timeIntervalSince1970:(lastViewedTimeStamp / 1000))
                    channel.isUnread = channel.lastPostAt > lastViewedDate
                }
            }
            
            return channels
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}
