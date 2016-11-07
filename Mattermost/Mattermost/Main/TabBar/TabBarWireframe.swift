//
//  TabBarTabBarWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias TabBarConfiguration = (TabBarConfigurator) -> Void

class TabBarWireframe {
    
    class func setup(_ viewController: TabBarViewController,
                     withCoordinator coordinator: TabBarCoordinator,
                     configutation: TabBarConfiguration? = nil) {
        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
