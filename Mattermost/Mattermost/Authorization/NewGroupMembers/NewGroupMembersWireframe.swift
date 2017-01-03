//
//  NewGroupMembersNewGroupMembersWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias NewGroupMembersConfiguration = (NewGroupMembersConfigurator) -> Void

class NewGroupMembersWireframe {
    
    class func setup(_ viewController: NewGroupMembersViewController,
                     withCoordinator coordinator: NewGroupMembersCoordinator,
                     configutation: NewGroupMembersConfiguration? = nil) {
        let interactor = NewGroupMembersInteractor()
        let presenter = NewGroupMembersPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
