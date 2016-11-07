//
//  TeamSelectionTeamSelectionWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias TeamSelectionConfiguration = (TeamSelectionConfigurator) -> Void

class TeamSelectionWireframe {
    
    class func setup(_ viewController: TeamSelectionViewController,
                     withCoordinator coordinator: TeamSelectionCoordinator,
                     configutation: TeamSelectionConfiguration? = nil) {
        let interactor = TeamSelectionInteractor()
        let presenter = TeamSelectionPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
