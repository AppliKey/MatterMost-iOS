//
//  TabBarTabBarPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class TabBarPresenter {
    
	//MARK: - Properties
    weak var view: TabBarViewing!
    var interactor: TabBarInteracting!
	
	//MARK: - Init
    
    required init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: TabBarCoordinator
}

extension TabBarPresenter: TabBarConfigurator {
}

extension TabBarPresenter: TabBarPresenting {
    func hideUnreadController() {
        coordinator.hideUnreadController()
    }
    
    func showUnreadController() {
        coordinator.showUnreadController()
    }
}

extension TabBarPresenter: TabBarEventHandling {
    func viewIsReady() {
        interactor.checkUnreadController()
        //For Test
        view.showBadge(atController: .Direct)
    }
}
