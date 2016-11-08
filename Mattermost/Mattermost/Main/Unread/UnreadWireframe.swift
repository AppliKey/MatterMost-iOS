//
//  UnreadUnreadWireframe.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 08/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias UnreadConfiguration = (UnreadConfigurator) -> Void

class UnreadWireframe {
    
    class func setup(_ viewController: UnreadViewController,
                     withCoordinator coordinator: UnreadCoordinator,
                     configutation: UnreadConfiguration? = nil) {
        let interactor = UnreadInteractor()
        let presenter = UnreadPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
