//
//  MattermostTarget.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/13/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya

protocol EncodingProvider {
    var parameterEncoding: Moya.ParameterEncoding {get}
}

protocol MattermostTarget: TargetType, EncodingProvider {
    var apiPath: String {get}
}

extension MattermostTarget {
    var apiPath: String {
        return "/api/v3"
    }
}

extension TargetType where Self: MattermostTarget {
    
    var baseURL: URL {
        guard let serverAddress = SessionManager.shared.serverAddress else {
            fatalError("No server address")
        }
        guard let url = URL(string: serverAddress) else {
            fatalError("Server address is invalid")
        }
        return url.appendingPathComponent(apiPath)
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.prettyPrinted
        default:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var defaultEndpoint: Endpoint<Self> {
        let url = self.baseURL.appendingPathComponent(self.path).absoluteString
        var endpoint = Endpoint<Self>(URL: url,
                                      sampleResponseClosure: {.networkResponse(200, self.sampleData)},
                                      method: self.method,
                                      parameters: self.parameters,
                                      parameterEncoding: self.parameterEncoding)
        if let token = SessionManager.shared.token {
            endpoint = endpoint.adding(newHttpHeaderFields: ["Authorization": token])
        }
        return endpoint
    }
    
}
