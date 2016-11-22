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
            let channels = (try? unbox(dictionary: json, atKey: "channels")) ?? [Channel]()
            return channels
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}
