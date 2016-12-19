//
//  ErrorMapper.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/14/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Unbox
import Moya
import Rswift

typealias ErrorMappingCompletion = (String, ClientError?) -> ()

class ErrorMapper {
    
    func message(for error: Swift.Error) -> String {
        switch error {
        case Moya.Error.statusCode(let response): return mapClientError(for: response)
        case Moya.Error.jsonMapping(let response): return mapJSONMappingError(for: response)
        case Moya.Error.underlying(let error): return error.localizedDescription
        case let error as UnboxError: return error.description
        default: return unknownError()
        }
    }
    
    func clientError(for error: Swift.Error?) -> ClientError? {
        if let error = error as? Moya.Error, let response = error.response {
            return try? clientError(for: response)
        }
        return nil
    }
    
    func clientError(for response: Moya.Response) -> ClientError? {
        return try? clientError(for: response)
    }
    
    //MARK: - Private
    
    private func clientError(for response: Moya.Response) throws -> ClientError {
        let clientError = try unbox(data: response.data) as ClientError
        print("Client error: \(clientError.message)")
        return clientError
    }
    
    private func mapClientError(for response: Moya.Response) -> String {
        do {
            return try clientError(for: response).message
        } catch {
            return message(for: error)
        }
    }
    
    private func mapJSONMappingError(for response: Moya.Response) -> String {
        do {
            return try response.mapString()
        } catch {
            return message(for: error)
        }
    }
    
    private func unknownError() -> String {
        return R.string.localizable.unknownServerError()
    }
    
}

