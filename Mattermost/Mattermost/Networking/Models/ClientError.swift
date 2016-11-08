//
//  ClientError.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

class ClientError: Mappable {
    var id: String?
    var message: String?
    var detailedError: String?
    var requestId: String?
    var statusCode: Int?
    var isOauth: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.message <- map["message"]
        self.detailedError <- map["detailed_error"]
        self.requestId <- map["request_id"]
        self.statusCode <- map["status_code"]
        self.isOauth <- map["is_oauth"]
    }
}
