//
//  ServerPingTarget.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/20/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct ServerPingTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let address: String
    
    //MARK: - MattermostTarget -
    
    let path = "/general/ping"
    
    var baseURL: URL {
        guard let url = URL(string: address) else {
            fatalError("Server address is invalid")
        }
        return url.appendingPathComponent(apiPath)
    }
    
    func map(_ response: Moya.Response) throws -> ServerPingInfo {
        return try unbox(data: response.data) as ServerPingInfo
    }
    
}

extension UnboxError {
    init(message: String) {
        self.description = "[UnboxError] " + message
    }
}
