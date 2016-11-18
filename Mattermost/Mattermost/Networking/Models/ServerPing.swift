//
//  ServerPing.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

class ServerPing: Mappable {
    var nodeId: String?
    var serverTime: String?
    var version: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.nodeId <- map["node_id"]
        self.serverTime <- map["server_time"]
        self.version <- map["version"]
    }
}
