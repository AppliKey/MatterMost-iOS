//
//  SignInSignInInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class SignInInteractor: EmailValidator, PasswordValidator {
  	weak var presenter: SignInPresenting!
}

extension SignInInteractor: SignInInteracting {
    
    func signIn(withEmail email: String, password: String, completion: (Result<Void>) -> Void) {
        guard validateEmail(email) else {
            completion(.failure(R.string.localizable.emailNotValid()))
            return
        }
        guard validatePassword(password) else {
            completion(.failure(R.string.localizable.passwordNotValid()))
            return
        }
        //TODO: request sign in
        completion(.success())
    }
    
}
