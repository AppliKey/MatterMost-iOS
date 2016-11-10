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
    func isAddressValid(address: String, completion: @escaping (_ isValid: Bool, _ message: String?) -> ())
}

protocol ServerSelectionPresenting: class {
}

protocol ServerSelectionViewing: class {
}

protocol ServerSelectionEventHandling: class {
    func handleServerAddress(address: String)
}

protocol ServerSelectionCoordinator: class {
    func signIn()
}
    
