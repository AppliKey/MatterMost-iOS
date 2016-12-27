//
//  NewGroupNewGroupWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias NewGroupConfiguration = (NewGroupConfigurator) -> Void

class NewGroupWireframe {
    
    class func setup(_ viewController: NewGroupViewController,
                     withCoordinator coordinator: NewGroupCoordinator,
                     configutation: NewGroupConfiguration? = nil) {
        let interactor = NewGroupInteractor(service: UsersService())
        let presenter = NewGroupPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
