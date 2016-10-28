//
//  ServerSelectionServerSelectionProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation

protocol ServerSelectionConfigurator: class {
  weak var delegate: ServerSelectionDelegate? {get set}
}

protocol ServerSelectionDelegate: class {
}

protocol ServerSelectionInteracting: class {
}

protocol ServerSelectionPresenting: class {
}

protocol ServerSelectionViewing: class {
}

protocol ServerSelectionEventHandler: class {
}

protocol ServerSelectionRouting: class {
}

protocol ServerSelectionCoordinator: class {
}
