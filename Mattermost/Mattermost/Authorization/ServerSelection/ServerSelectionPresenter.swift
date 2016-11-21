//
//  ServerSelectionServerSelectionPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ServerSelectionPresenter: ServerSelectionConfigurator {
    
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

extension ServerSelectionPresenter: ServerSelectionEventHandling {
    
    func handleServerAddress(address: String) {
        view.showActivityIndicator()
        interactor.ping(address: address)
    }
    
}

extension ServerSelectionPresenter: ServerSelectionPresenting {
    
    func completeServerSelection() {
        view.hideActivityIndicator()
        coordinator.signIn()
    }
    
    func present(_ errorMessage: String) {
        view.hideActivityIndicator()
        view.alert(errorMessage)
    }
    
}
