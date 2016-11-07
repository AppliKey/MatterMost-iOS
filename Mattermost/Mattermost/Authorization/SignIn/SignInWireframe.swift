//
//  SignInWireframe.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/4/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias SignInConfiguration = (SignInConfigurator) -> Void

class SignInWireframe {
    
    class func setup(_ viewController: SignInViewController,
                     withCoordinator coordinator: SignInCoordinator,
                     configutation: SignInConfiguration? = nil) {
        let interactor = SignInInteractor()
        let presenter = SignInPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        configutation?(presenter)
    }
    
}
