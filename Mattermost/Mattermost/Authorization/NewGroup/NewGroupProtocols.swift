//
//  NewGroupNewGroupProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol NewGroupConfigurator: class {
}

protocol NewGroupInteracting: class {
    func loadUsers()
}

protocol NewGroupPresenting: class {
    func present(_ users: [User])
    func present(_ errorMessage: String)
}

protocol NewGroupViewing: class, AlertShowable {
    func show(_ users: [UserRepresantation])
}

protocol NewGroupEventHandling: class {
    func viewDidLoad()
}

protocol NewGroupCoordinator: class {
}
