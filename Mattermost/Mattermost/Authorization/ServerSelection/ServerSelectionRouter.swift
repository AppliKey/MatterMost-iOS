//
//  ServerSelectionServerSelectionRouter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 Vladimir Kravchenko. All rights reserved.
//

import UIKit

class ServerSelectionRouter: BaseRouter {
    weak var delegate: AnyObject!
    weak var viewController: UIViewController!
    private let coordinator: ServerSelectionCoordinator
    
    init(withCoordinator coordinator: ServerSelectionCoordinator) {
        self.coordinator = coordinator
    }
}

extension ServerSelectionRouter: ServerSelectionRouting {
    
}
