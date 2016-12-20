//
//  NewGroupMembersNewGroupMembersPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class NewGroupMembersPresenter {
    
	//MARK: - Properties
    weak var view: NewGroupMembersViewing!
    var interactor: NewGroupMembersInteracting!
	
	//MARK: - Init
    
    required init(coordinator: NewGroupMembersCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: NewGroupMembersCoordinator
}

extension NewGroupMembersPresenter: NewGroupMembersConfigurator {
}

extension NewGroupMembersPresenter: NewGroupMembersPresenting {
}

extension NewGroupMembersPresenter: NewGroupMembersEventHandling {
}
