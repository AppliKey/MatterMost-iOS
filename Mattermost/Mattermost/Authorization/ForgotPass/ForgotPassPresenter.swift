//
//  ForgotPassForgotPassPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ForgotPassPresenter {
    
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

extension ForgotPassPresenter: ForgotPassConfigurator {
}

extension ForgotPassPresenter: ForgotPassPresenting {
}

extension ForgotPassPresenter: ForgotPassEventHandling {
}
