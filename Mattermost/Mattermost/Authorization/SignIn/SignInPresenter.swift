//
//  SignInSignInPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SignInPresenter {
    
	//MARK: Properties
    weak var view: SignInViewing!
    var interactor: SignInInteracting!
    var router: SignInRouting!
	
	//MARK: Init
    
    required init(coordinator: SignInCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Private
    fileprivate let coordinator: SignInCoordinator
}

extension SignInPresenter: SignInConfigurator {
}

extension SignInPresenter: SignInPresenting {
}

extension SignInPresenter: SignInEventHandling {
}
