//
//  TeamSelectionTeamSelectionPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class TeamSelectionPresenter {
    
	//MARK: - Properties
    weak var view: TeamSelectionViewing!
    var interactor: TeamSelectionInteracting!
	
	//MARK: - Init
    
    required init(coordinator: TeamSelectionCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: TeamSelectionCoordinator
}

extension TeamSelectionPresenter: TeamSelectionConfigurator {
}

extension TeamSelectionPresenter: TeamSelectionPresenting {
}

extension TeamSelectionPresenter: TeamSelectionEventHandling {
}
