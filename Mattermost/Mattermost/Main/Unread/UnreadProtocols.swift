//
//  UnreadUnreadProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 08/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol UnreadConfigurator: class {
}

protocol UnreadInteracting: class {
}

protocol UnreadPresenting: class {
}

protocol UnreadViewing: class {
}

protocol UnreadEventHandling: class {
    func openMenu()
}

protocol UnreadCoordinator: class {
    func openMenu(fromViewController viewController: UIViewController)
}
