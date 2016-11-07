//
//  SignInSignInProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol SignInConfigurator: class {
}

protocol SignInInteracting: class {
    func signIn(withEmail email: String, password: String, completion: (Result<Void>) -> Void)
}

protocol SignInPresenting: class {
}

protocol SignInViewing: class {
}

protocol SignInEventHandling: class {
    func next(withEmail email: String, andPassword password: String)
    func forgotPass(forEmail email: String)
}

protocol SignInCoordinator: class {
    func forgotPass(forEmail email: String)
    func next()
    func alert(withMessage message: String)
}
