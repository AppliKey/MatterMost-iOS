//
//  TeamSelectionTeamSelectionProtocols.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol TeamSelectionConfigurator: class {
}

protocol TeamSelectionInteracting: class {
    func loadTeams()
    func save(_ team: Team)
}

protocol TeamSelectionPresenting: class {
    func present(_ teams: [Team])
    func present(_ errorMessage: String)
}

protocol TeamSelectionViewing: class, ErrorShowable, ActivityIndicating {
    func show(_ teams: [TeamRepresentation])
}

protocol TeamSelectionEventHandling: class {
    func refresh()
}

protocol TeamSelectionCoordinator: class {
    func showMain()
}
