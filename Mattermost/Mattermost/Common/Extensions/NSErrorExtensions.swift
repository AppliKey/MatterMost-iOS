//
//  NSErrorExtensions.swift
//
//  Copyright © 2016 Applikey Solutions. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(domain: String,
                     code: Int = 0,
                     failureReason: String = "Unknown error") {
        self.init(domain: domain, code: code, userInfo: [NSLocalizedFailureReasonErrorKey : failureReason])
    }
}
