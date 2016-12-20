//
//  NewGroupNewGroupPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class NewGroupPresenter {
    
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

extension NewGroupPresenter: NewGroupConfigurator {
}

extension NewGroupPresenter: NewGroupPresenting {
}

extension NewGroupPresenter: NewGroupEventHandling {
}
