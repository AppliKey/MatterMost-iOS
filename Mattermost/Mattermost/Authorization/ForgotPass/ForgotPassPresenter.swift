//
//  ForgotPassForgotPassPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ForgotPassPresenter: ForgotPassConfigurator {
    
	//MARK: - Properties
    weak var view: ForgotPassViewing!
    var interactor: ForgotPassInteracting!
    var email: String?
	
	//MARK: - Init
    
    required init(coordinator: ForgotPassCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: ForgotPassCoordinator
}

extension ForgotPassPresenter: ForgotPassEventHandling {
    func send(_ email: String) {
        view.showActivityIndicator()
        interactor.send(email)
    }
}

extension ForgotPassPresenter: ForgotPassPresenting {
    
    func complete() {
        view.hideActivityIndicator()
        view.alert(R.string.localizable.passwordWasReset()) {
            self.coordinator.back()
        }
    }
    
    func present(_ errorMessage: String) {
        view.hideActivityIndicator()
        view.alert(errorMessage)
    }
    
}
