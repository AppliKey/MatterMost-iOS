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
    func request<Target: MattermostTarget>(_ target: Target, queue: DispatchQueue?,
                 completion: @escaping Moya.Completion) -> CancellableRequest
}

extension NetworkService {
    func request<Target: MattermostTarget>(_ target: Target, queue: DispatchQueue? = DispatchQueue.main,
                 completion: @escaping Moya.Completion) -> CancellableRequest {
        return RequestManager.shared.request(target, queue: queue, completion: completion)
    }
}
