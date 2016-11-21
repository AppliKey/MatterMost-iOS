//
//  ClientError.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox

struct ClientError {
    let id: String
    let message: String
    let detailedError: String?
    let requestId: String?
    let statusCode: Int?
    let isOauth: Bool?
}

extension ClientError: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        message = try unboxer.unbox(key: "message")
        detailedError = unboxer.unbox(key: "detailed_error")
        requestId = unboxer.unbox(key: "request_id")
        statusCode = unboxer.unbox(key: "status_code")
        isOauth = unboxer.unbox(key: "is_oauth")
    }
}
