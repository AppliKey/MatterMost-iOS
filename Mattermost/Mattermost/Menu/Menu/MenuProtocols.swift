//
//  MenuMenuProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol MenuConfigurator: class {
}

protocol MenuInteracting: class {
}

protocol MenuPresenting: class {
}

protocol MenuViewing: class {
    func updateView(withViewModel vm: MenuViewModel)
}

protocol MenuEventHandling: class {
    func viewIsReady()
    func handleRowSelection(withIndexPath index:IndexPath)
    func createGroup()
}

protocol MenuCoordinator: class {
    func openSettings()
    func createGroup()
}
