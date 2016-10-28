//
//  ServerSelectionServerSelectionInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation

class ServerSelectionInteractor: BaseInteractor {
  typealias PresenterType = ServerSelectionPresenting
  weak var presenter: ServerSelectionPresenting!
}

extension ServerSelectionInteractor: ServerSelectionInteracting {
}
