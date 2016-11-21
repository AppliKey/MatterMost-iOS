//
//  SignInSignInInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Result

class SignInInteractor: EmailValidator, PasswordValidator {
  	weak var presenter: SignInPresenting!
    
    //MARK: - Init
    init(withService service: SignInService) {
        self.service = service
    }
    
    //MARK: - Private -
    fileprivate let service: SignInService
    fileprivate var request: CancellableRequest?
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
}

extension SignInInteractor: SignInInteracting {
    
    func signIn(withEmail email: String, password: String) {
        guard validateEmail(email) else {
            let error = SignInError.email(R.string.localizable.emailNotValid())
            presenter.present(error)
            return
        }
        guard validatePassword(password) else {
            let error = SignInError.password(R.string.localizable.passwordNotValid())
            presenter.present(error)
            return
        }
        request = service.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success: self?.presenter.completeSignIn()
            case .failure(let error): self?.presenter.present(error)
            }
        }
    }
    
}

enum SignInError: Swift.Error {
    case password(String), email(String), other(String)
}

enum SignInResult {
    case success, failure(SignInError)
}

typealias SignInCompletion = (SignInResult) -> ()

protocol SignInService {
    func signIn(email: String, password: String,
                completion: @escaping SignInCompletion) -> CancellableRequest
}
