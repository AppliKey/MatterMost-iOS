//
//  SignInSignInInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

protocol SignInService {
    func signIn(withEmail email: String, password: String, completion: (Result<Void>) -> Void)
}

class SignInInteractor: EmailValidator, PasswordValidator {
  	weak var presenter: SignInPresenting!
    var signInService = AuthorizationService()
}

extension SignInInteractor: SignInInteracting {
    
    func signIn(withEmail email: String, password: String, completion: (Result<Void>) -> Void) {
        guard validateEmail(email) else {
            completion(.failure(NSError(domain:R.string.localizable.emailNotValid())))
            return
        }
        guard validatePassword(password) else {
            completion(.failure(NSError(domain: R.string.localizable.passwordNotValid())))
            return
        }
        //TODO: request sign in
        signInService.signIn(withEmail: email, password: password, completion: completion)
    }
    
}
