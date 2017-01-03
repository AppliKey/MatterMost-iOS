//
//  AuthorizationService.swift
//  Mattermost
//
//  Created by torasike on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

class AuthorizationService: NetworkService {
    fileprivate let errorMapper = ErrorMapper()
}

extension AuthorizationService: PingService {
    
    func ping(_ address: String, completion: @escaping PingCompletion) -> CancellableRequest {
        let target = ServerPingTarget(address: address)
        return request(target) {
            do {
                let pingInfo = try target.map($0)
                print("Server verion: \(pingInfo.version)")
                SessionManager.shared.serverVersion = pingInfo.version
                SessionManager.shared.serverAddress = address
                completion(.success)
            } catch {                
                let nsError = error as NSError
                var errorMessage = R.string.localizable.serverIsWrong()
                switch nsError.code {
                case NSURLErrorTimedOut, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
                     errorMessage = self.errorMapper.message(for: error)
                default: break
                }
                completion(.failure(errorMessage))
            }
        }
    }
    
}

extension AuthorizationService: AllTeamsService {
    
    func getAllTeams(completion: @escaping TeamsCompletion) -> CancellableRequest {
        let target = AllTeamsTarget()
        return request(target) {
            do {
                let teams = try target.map($0)
                completion(.success(teams))
            } catch {
                let errorMessage = self.errorMapper.message(for: error)
                completion(.failure(errorMessage))
            }
        }
    }
    
}

extension AuthorizationService: SignInService {
    
    func signIn(email: String, password: String,
                completion: @escaping SignInCompletion) -> CancellableRequest {
        let target = SignInTarget(email: email, password: password)
        return request(target) {
            do {
                let response = try $0.dematerialize().filterSuccessfulStatusCodes()
                let user = try target.map(response)
                SessionManager.shared.user = user
                self.findToken(in: response)
                completion(.success)
            } catch {
                self.handle(error, completion: completion)
            }
        }
    }
    
    private func findToken(in response: Moya.Response) {
        if let httpResponse = response.response as? HTTPURLResponse,
            let token = httpResponse.allHeaderFields["Token"] as? String {
            SessionManager.shared.token = "Bearer " + token
        }
    }
    
    private func handle(_ error: Swift.Error, completion: SignInCompletion) {
        if let clientError = errorMapper.clientError(for: error) {
            completion(.failure(signInError(for: clientError)))
        } else {
            let errorMessage = errorMapper.message(for: error)
            completion(.failure(.other(errorMessage)))
        }
    }
    
    private func signInError(for clientError: ClientError) -> SignInError {
        switch clientError.id {
        case "api.user.check_user_password.invalid.app_error", "api.user.login.blank_pwd.app_error":
            return .password(clientError.message)
        case "store.sql_user.get_for_login.app_error":
            return .email(clientError.message)
        default:
            return .other(clientError.message)
        }
    }
    
}

extension AuthorizationService: ResetPassService {
    
    func resetPass(for email: String, completion: @escaping (ResetPassResult) -> ()) -> CancellableRequest {
        let target = ResetPassTarget(email: email)
        return request(target) {
            do {
                _ = try $0.dematerialize().filterSuccessfulStatusCodes()
                completion(.success)
            } catch {
                let errorMessage = self.errorMapper.message(for: error)
                completion(.failure(errorMessage))
            }
        }
    }
    
}



