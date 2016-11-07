//
//  ForgotPassForgotPassWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias ForgotPassConfiguration = (ForgotPassConfigurator) -> Void

class ForgotPassWireframe {
    
    class func setup(_ viewController: ForgotPassViewController,
                     withCoordinator coordinator: ForgotPassCoordinator,
                     configutation: ForgotPassConfiguration? = nil) {
        let interactor = ForgotPassInteractor()
        let presenter = ForgotPassPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
