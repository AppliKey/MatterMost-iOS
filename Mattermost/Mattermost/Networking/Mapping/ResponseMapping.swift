//
//  ResponseMapping.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/20/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result

protocol ResponseMapping {
    associatedtype Object
    func map(_ result: MoyaResult) throws -> Object
    func map(_ response: Moya.Response) throws -> Object
}

extension ResponseMapping {
    
    func map(_ result: MoyaResult) throws -> Object {
        let response = try result.dematerialize().filterSuccessfulStatusCodes()
        return try map(response)
    }
    
}
