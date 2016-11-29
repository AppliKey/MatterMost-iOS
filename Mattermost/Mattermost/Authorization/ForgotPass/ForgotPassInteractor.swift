//
//  ForgotPassForgotPassInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ForgotPassInteractor: EmailValidator {
  	weak var presenter: ForgotPassPresenting!
    
    //MARK: - Init
    init(service: ResetPassService) {
        self.service = service
    }
    
    //MARK: - Private -
    let service: ResetPassService
    var request: CancellableRequest?
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
}

extension ForgotPassInteractor: ForgotPassInteracting {
    func send(_ email: String) {
        guard validateEmail(email) else {
            let message = R.string.localizable.emailNotValid()
            presenter.present(message)
            return
        }
        request = service.resetPass(for: email) { [weak self] result in
            switch result {
            case .success: self?.presenter.complete()
            case .failure(let message): self?.presenter.present(message)
            }
        }
    }
}

enum ResetPassResult {
    case success, failure(String)
}

typealias ResetPassCompletion = (ResetPassResult) -> ()

protocol ResetPassService {
    func resetPass(for email: String, completion: @escaping ResetPassCompletion) -> CancellableRequest
}
