     //
//  ForgotPassForgotPassProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol ForgotPassConfigurator: class {
    var email: String? {get set}
}

protocol ForgotPassInteracting: class {
    func send(_ email: String)
}

protocol ForgotPassPresenting: class {
    func complete()
    func present(_ errorMessage: String)
}

protocol ForgotPassViewing: class, ActivityIndicating, AlertShowable {
}

protocol ForgotPassEventHandling: class {
    func send(_ email: String)
}

protocol ForgotPassCoordinator: class {
    func back()
}
