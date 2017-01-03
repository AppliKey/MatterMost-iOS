//
//  NewGroupNewGroupInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class NewGroupInteractor {
  	weak var presenter: NewGroupPresenting!
    
    //MARK: - Init
    init(service: AllUsersService) {
        self.service = service
    }
    
    //MARK: - Private
    fileprivate let service: AllUsersService
    fileprivate var request: CancellableRequest?
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
}

extension NewGroupInteractor: NewGroupInteracting {
    
    func loadUsers() {
        request = service.getAllUsers { [weak self] result in
            switch result {
            case .success(let users):
                let thisUserId = SessionManager.shared.user?.id
                let sortedUsers = users
                    .filter{ $0.id != thisUserId }
                    .sorted{ $0.0.username < $0.1.username }
                self?.presenter.present(sortedUsers)
            case .failure(let message):
                self?.presenter.present(message)
            }
        }
    }
    
}

enum UsersResult {
    case success([User]), failure(String)
}

typealias UsersCompletion = (UsersResult) -> ()

protocol AllUsersService {
    func getAllUsers(completion: @escaping UsersCompletion) -> CancellableRequest
}
