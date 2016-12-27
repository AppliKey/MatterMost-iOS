//
//  NewGroupNewGroupPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class NewGroupPresenter: NewGroupConfigurator {
    
	//MARK: - Properties
    weak var view: NewGroupViewing!
    var interactor: NewGroupInteracting!
	
	//MARK: - Init
    
    required init(coordinator: NewGroupCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: NewGroupCoordinator
}

extension NewGroupPresenter: NewGroupEventHandling {
    func viewDidLoad() {
        interactor.loadUsers()
    }
}

extension NewGroupPresenter: NewGroupPresenting {
    
    func present(_ users: [User]) {
        let represantations = users.map(userRepresentation)
        view.show(represantations)
    }
    
    func present(_ errorMessage: String) {
        view.alert(errorMessage)
    }
    
    private func userRepresentation(for user: User) -> UserRepresantation {
        return UserRepresantation(name: user.username, avatarURL: user.avatarUrl)
    }
    
}

struct UserRepresantation {
    let name: String
    let avatarURL: URL?
}
