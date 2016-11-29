//
//  SignInSignInProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import Result

protocol SignInConfigurator: class {
}

protocol SignInInteracting: class {
    func signIn(withEmail email: String, password: String)
}

protocol SignInPresenting: class {
    func completeSignIn()
    func present(_ error: SignInError)
}

protocol SignInViewing: class, ActivityIndicating, AlertShowable {
    func show(_ error: SignInError)
}

protocol SignInEventHandling: class {
    func next(withEmail email: String, andPassword password: String)
    func forgotPass(forEmail email: String)
}

protocol SignInCoordinator: class {
    func forgotPass(forEmail email: String)
    func selectTeam()
}
