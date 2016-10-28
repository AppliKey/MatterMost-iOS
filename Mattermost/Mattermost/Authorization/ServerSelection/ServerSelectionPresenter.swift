//
//  ServerSelectionServerSelectionPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation

class ServerSelectionPresenter: BasePresenter {
  typealias ViewType = ServerSelectionViewing
  weak var delegate: ServerSelectionDelegate?
  weak var view: ServerSelectionViewing!
  var interactor: ServerSelectionInteracting!
  var router: ServerSelectionRouting!
}

extension ServerSelectionPresenter: ServerSelectionConfigurator {
}

extension ServerSelectionPresenter: ServerSelectionPresenting {
}

extension ServerSelectionPresenter: ServerSelectionEventHandler {
}
