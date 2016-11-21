//
//  TeamSelectionTeamSelectionInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class TeamSelectionInteractor {
  	weak var presenter: TeamSelectionPresenting!
    
    //MARK: - Init
    init(service: AllTeamsService) {
        self.service = service
    }
    
    //MARK: - Private
    fileprivate let service: AllTeamsService
    fileprivate var request: CancellableRequest?
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
}

extension TeamSelectionInteractor: TeamSelectionInteracting {
    
    func loadTeams() {
        request = service.getAllTeams { [weak self] result in
            switch result {
            case .success(let teams): self?.presenter.present(teams)
            case .failure(let errorMessage): self?.presenter.present(errorMessage)
            }
        }
    }
    
    func save(_ team: Team) {
        SessionManager.shared.team = team
    }
    
}

enum TeamsResult {
    case success([Team]), failure(String)
}

typealias TeamsCompletion = (TeamsResult) -> ()

protocol AllTeamsService {
    func getAllTeams(completion: @escaping TeamsCompletion) -> CancellableRequest
}
