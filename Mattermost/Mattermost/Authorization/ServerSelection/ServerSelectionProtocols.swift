//
//  ServerSelectionServerSelectionProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol ServerSelectionConfigurator: class {
}

protocol ServerSelectionInteracting: class {
    func ping(address: String)
}

protocol ServerSelectionPresenting: class {
    func completeServerSelection()
    func present(_ errorMessage: String)
}

protocol ServerSelectionViewing: class, ActivityIndicating, AlertShowable {
}

protocol ServerSelectionEventHandling: class {
    func handleServerAddress(address: String)
}

protocol ServerSelectionCoordinator: class {
    func signIn()
}
    
