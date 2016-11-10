//
//  UnreadUnreadPresenter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 08/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class UnreadPresenter {
    
	//MARK: - Properties
    weak var view: UnreadViewing!
    var interactor: UnreadInteracting!
	
	//MARK: - Init
    
    required init(coordinator: UnreadCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: UnreadCoordinator
}

extension UnreadPresenter: UnreadConfigurator {
}

extension UnreadPresenter: UnreadPresenting {
}

extension UnreadPresenter: UnreadEventHandling {
    func openMenu() {
        coordinator.openMenu()
    }
}
