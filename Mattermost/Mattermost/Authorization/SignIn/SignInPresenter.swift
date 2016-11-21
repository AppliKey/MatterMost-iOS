//
//  SignInSignInPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SignInPresenter: SignInConfigurator {
    
	//MARK: - Properties
    weak var view: SignInViewing!
    var interactor: SignInInteracting!
	
	//MARK: - Init
    
    required init(coordinator: SignInCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: SignInCoordinator
}

extension SignInPresenter: SignInEventHandling {
    
    func forgotPass(forEmail email: String) {
        coordinator.forgotPass(forEmail: email)
    }
    
    func next(withEmail email: String, andPassword password: String) {
        view.showActivityIndicator()
        interactor.signIn(withEmail: email, password: password)
    }
    
}

extension SignInPresenter: SignInPresenting {
    
    func completeSignIn() {
        view.hideActivityIndicator()
        coordinator.selectTeam()
    }
    
    func present(_ error: SignInError) {
        view.hideActivityIndicator()
        view.show(error)
    }
    
}
