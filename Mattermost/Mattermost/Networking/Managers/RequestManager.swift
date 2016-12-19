//
//  RequestManager.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class RequestManager {
    
    //MARK: - Shared
    static let shared = RequestManager()
    
    func request<Target: MattermostTarget>(_ target: Target,
                 queue: DispatchQueue? = DispatchQueue.main,
                 completion: @escaping Moya.Completion) -> CancellableRequest {
        let provider = MoyaProvider<Target>(endpointClosure: { $0.endpoint },
                                            manager: manager)
        return provider.request(target, queue: queue, completion: completion)
    }
    
    //MARK: - Private -
    
    private lazy var manager: Alamofire.SessionManager = self.makeManager()
    
    private func makeManager() -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
    
}
