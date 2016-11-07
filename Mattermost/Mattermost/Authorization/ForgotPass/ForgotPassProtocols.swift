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
}

protocol ForgotPassPresenting: class {
}

protocol ForgotPassViewing: class {
}

protocol ForgotPassEventHandling: class {
}

protocol ForgotPassCoordinator: class {
}
