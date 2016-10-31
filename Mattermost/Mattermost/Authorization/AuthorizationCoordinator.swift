//
//  AuthorizationCoordinator.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationCoordinator {
    
    func startViewController() -> UIViewController {
        guard let viewController = R.storyboard.authorization.serverSelectionViewController()
            else { fatalError("Can't instantiate server selection view controller") }
        let interactor = ServerSelectionInteractor()
        let router = ServerSelectionRouter()
        let presenter = ServerSelectionPresenter(coordinator: self)
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}

extension AuthorizationCoordinator: ServerSelectionCoordinator {
    
    func signInViewController() -> UIViewController {
        guard let viewController = R.storyboard.authorization.signInViewController()
            else { fatalError("Can't instantiate sign in view controller") }
        let interactor = SignInInteractor()
        let router = SignInRouter()
        let presenter = SignInPresenter(coordinator: self)
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
    
}

extension AuthorizationCoordinator: SignInCoordinator {
    
}
