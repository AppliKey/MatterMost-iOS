//
//  TeamSelectionTeamSelectionPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class TeamSelectionPresenter: TeamSelectionConfigurator {
    
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

extension TeamSelectionPresenter: TeamSelectionEventHandling {
    
    func refresh() {
        view.showActivityIndicator()
        interactor.loadTeams()
    }
    
}

extension TeamSelectionPresenter: TeamSelectionPresenting {
    
    func present(_ teams: [Team]) {
        view.hideActivityIndicator()
        view.show(teams.map(representation))
    }
    
    func present(_ errorMessage: String) {
        view.alert(errorMessage)
    }
    
    private func representation(for team: Team) -> TeamRepresentation {
        return TeamRepresentation(name: team.displayName, selection: selection(for: team))
    }
    
    private func selection(for team: Team) -> VoidClosure {
        return {
            self.interactor.save(team)
            self.coordinator.showMain()
        }
    }
    
}
