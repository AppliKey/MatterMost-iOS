//
//  AllTeamsTarget.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/20/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Unbox

struct AllTeamsTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - MattermostTarget -
    
    let path = "/teams/all"
    
    func map(_ response: Moya.Response) throws -> [Team] {
        if let json = try response.mapJSON() as? UnboxableDictionary {
            var teams: [Team] = []
            for key in json.keys {
                if let team = try? unbox(dictionary: json, atKey: key) as Team {
                    teams.append(team)
                }
            }
            return teams
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
    
}

