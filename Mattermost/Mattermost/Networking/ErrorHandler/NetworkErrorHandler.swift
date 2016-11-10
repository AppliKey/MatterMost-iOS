//
//  NetworkErrorHandler.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

class NetworkErrorHandler {
    
    
    func handleUnauthorizedRequest() {
        
    }
    
    func handleUnavailableURL() {
        
    }
    
    func mattermostClientErrorForResponse(response: Any) -> MattermostClientError {
        let clientError = Mapper<ClientError>().map(JSONObject: response)
        return MattermostClientError(error: clientError)
    }
}

enum MattermostClientError: Error {
    case UserLoginBlankPassword
    case UnknownError
}

extension MattermostClientError {
    
    init(error: ClientError?) {
        guard let id = error?.id else {
            self = MattermostClientError.UnknownError
            return
        }
        switch id {
        case "api.user.login.blank_pwd.app_error":
            self = MattermostClientError.UserLoginBlankPassword
        default:
            self = MattermostClientError.UnknownError
        }
    }
}
