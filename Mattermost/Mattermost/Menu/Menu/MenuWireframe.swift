//
//  MenuMenuWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias MenuConfiguration = (MenuConfigurator) -> Void

class MenuWireframe {
    
    class func setup(_ viewController: MenuViewController,
                     withCoordinator coordinator: MenuCoordinator,
                     configutation: MenuConfiguration? = nil) {
        let interactor = MenuInteractor()
        let presenter = MenuPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
