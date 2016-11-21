//
//  ServerPing.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

struct ServerPingInfo {
    let version: String
    let serverTime: Date
    let nodeId: String?
}

extension ServerPingInfo: Unboxable {
    init(unboxer: Unboxer) throws {
        version = try unboxer.unbox(key: "version")
        let miliseconds: TimeInterval = try unboxer.unbox(key: "server_time")
        serverTime = Date.init(timeIntervalSince1970: miliseconds / 1000)
        nodeId = unboxer.unbox(key: "node_id")
    }
}
