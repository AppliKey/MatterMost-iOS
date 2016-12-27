//
//  UsersService.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/23/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

class UsersService: NetworkService {
    fileprivate let errorMapper = ErrorMapper()
}

extension UsersService: AllUsersService {
    func getAllUsers(completion: @escaping UsersCompletion) -> CancellableRequest {
        guard let teamId = SessionManager.shared.team?.id else {
            fatalError("Team is not selected")
        }
        let target = AllUsersTarget(teamId: teamId)
        return request(target) {
            do {
                let users = try target.map($0)
                completion(.success(users))
            } catch {
                let errorMessage = self.errorMapper.message(for: error)
                completion(.failure(errorMessage))
            }
        }
    }
}


