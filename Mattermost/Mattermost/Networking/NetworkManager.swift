//
//  NetworkManager.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import Locksmith

typealias AlamofireCompletion = (DataResponse<Any>) -> Void

class NetworkManager {
    static let shared = NetworkManager()
    
    var errorHandler = NetworkErrorHandler()
    var sessionManager = SessionManager()
    var baseURL: URL!
    
    
    private func requestInfo(forRoute route: APIRoute) -> (method: Alamofire.HTTPMethod, URL: URL, encoding: ParameterEncoding, headers: [String: String]?) {
        return (route.method, baseURL.appendingPathComponent(route.path), URLEncoding.default, nil)
    }
    
    func performRequest<T: BaseMappable>(route: APIRoute,
                        mapping: ((_ responce: Any) -> T?)? = nil,
                        completion: @escaping (Result<T?>) -> Void) {
        let requestInfo = self.requestInfo(forRoute: route)
        let responseCompletion = jsonCompletion(forRequestCompletion: completion, mapping: mapping)
        
        Alamofire.request(requestInfo.URL,
                          method: requestInfo.method,
                          parameters: route.parameters,
                          encoding: requestInfo.encoding,
                          headers: requestInfo.headers).responseJSON(completionHandler: responseCompletion)
    }
    
    private func jsonCompletion<T: BaseMappable>(forRequestCompletion completion: @escaping (Result<T?>) -> Void,
                                                                         mapping: ((_ responce: Any) -> T?)?) -> AlamofireCompletion {
        return {[weak self] response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let responseResult):
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(NSError(domain: String(describing: self))))
                    return
                }
                if (200..<300).contains(statusCode) {
                    completion(.success(mapping?(responseResult)))
                } else {
                    if statusCode == 401 {
                        self?.errorHandler.handleUnauthorizedRequest()
                    } else if statusCode == 410 {
                        self?.errorHandler.handleUnavailableURL()
                    } else {
                        guard let error = self?.errorHandler.mattermostClientErrorForResponse(response: responseResult) else { return }
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    
}
