//
//  NetworkManager.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/6/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Alamofire

typealias AlamofireCompletion = (DataResponse<Any>) -> Void

class NetworkManager {
    
    static let shared = NetworkManager()
    let errorHandler = NetworkErrorHandler()
    private let manager = SessionManager()
    private var baseURL: URL {
        //TODO: get base url from defaults
        return URL(string: "")!
    }
    
    private func requestInfo(forRoute route: APIRoute) -> (method: Alamofire.HTTPMethod, URL: URL) {
        return (route.method, baseURL.appendingPathComponent(route.path))
    }
    
    func performRequest<T: ObjectMapper>(route: APIRoute,
                        objectMapper: T,
                        parameters: [String: AnyObject]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil,
                        completion: @escaping (Result<T.MappedType>) -> Void) {
        let requestInfo = self.requestInfo(forRoute: route)
        let responseCompletion = jsonCompletion(forRequestCompletion: completion, objectMapper: objectMapper)
        
        Alamofire.request(requestInfo.URL,
                          method: requestInfo.method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers).responseJSON(completionHandler: responseCompletion)
    }
    
    
    private func jsonCompletion<T:ObjectMapper >(forRequestCompletion completion: @escaping (Result<T.MappedType>) -> Void,
                                                                    objectMapper: T?) -> AlamofireCompletion {
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
                    objectMapper?.performMapping(response: responseResult, completion: { (result) in
                        switch result {
                        case .success(let object):
                            completion(.success(object))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    })
                } else {
                    if statusCode == 401 {
                        self?.errorHandler.handleUnauthorizedRequest()
                    } else if statusCode == 410 {
                        self?.errorHandler.handleunavailableURL()
                    } else {
                        let errorMessage = NSLocalizedString("Unknown Error", comment: "Unknown Error")
                        let json = responseResult as? NSDictionary
                        let message = json?["message"] as? String ?? errorMessage
                        let error = NSError(domain: String(describing: self), failureReason: message)
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    
}
