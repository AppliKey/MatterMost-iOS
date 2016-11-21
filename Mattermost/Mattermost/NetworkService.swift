//
//  NetworkService.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/20/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya

protocol NetworkService {
    func request<Target: MattermostTarget>(_ target: Target,
                 completion: @escaping Moya.Completion) -> CancellableRequest
}

extension NetworkService {
    func request<Target: MattermostTarget>(_ target: Target,
                 completion: @escaping Moya.Completion) -> CancellableRequest {
        let provider = MoyaProvider<Target>(endpointClosure: { $0.defaultEndpoint })
        return provider.request(target, completion: completion)
    }
}
