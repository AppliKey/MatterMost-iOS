//
//  SignInSignInInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SignInInteractor: BaseInteractor {
  	typealias PresenterType = SignInPresenting
  	weak var presenter: SignInPresenting!
}

extension SignInInteractor: SignInInteracting {
}
