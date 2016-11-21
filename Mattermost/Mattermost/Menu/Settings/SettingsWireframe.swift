//
//  SettingsSettingsWireframe.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias SettingsConfiguration = (SettingsConfigurator) -> Void

class SettingsWireframe {
    
    class func setup(_ viewController: SettingsViewController,
                     withCoordinator coordinator: SettingsCoordinator,
                     configutation: SettingsConfiguration? = nil) {
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
