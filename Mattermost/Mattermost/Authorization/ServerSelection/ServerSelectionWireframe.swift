//
//  ServerSelectionWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/4/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias ServerSelectionConfiguration = (ServerSelectionConfigurator) -> Void

class ServerSelectionWireframe {
    
    class func setup(_ view: ServerSelectionViewController,
                     withCoordinator coordinator: ServerSelectionCoordinator,
                     configutation: ServerSelectionConfiguration? = nil) {
        let interactor = ServerSelectionInteractor(service: AuthorizationService())
        let presenter = ServerSelectionPresenter(coordinator: coordinator)
        presenter.view = view
        presenter.interactor = interactor
        view.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
