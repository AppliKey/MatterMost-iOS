//
//  ServerSelectionServerSelectionPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ServerSelectionPresenter {
    
    //MARK: - Properties
    var interactor: ServerSelectionInteracting!
    weak var view: ServerSelectionViewing!
    
    //MARK: - Init
    
    required init(coordinator: ServerSelectionCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: ServerSelectionCoordinator
}

extension ServerSelectionPresenter: ServerSelectionConfigurator {
}

extension ServerSelectionPresenter: ServerSelectionPresenting {
}

extension ServerSelectionPresenter: ServerSelectionEventHandling {
    func handleServerAddress(address: String) {
        interactor.isAddressValid(address: address) { [weak self] (isValid, validationMessage) in
            guard isValid else { return }
            self?.coordinator.signIn()
        }
    }
}
