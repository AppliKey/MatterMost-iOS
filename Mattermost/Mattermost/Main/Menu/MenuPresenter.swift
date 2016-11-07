//
//  MenuMenuPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class MenuPresenter {
    
	//MARK: - Properties
    weak var view: MenuViewing!
    var interactor: MenuInteracting!
	
	//MARK: - Init
    
    required init(coordinator: MenuCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: MenuCoordinator
}

extension MenuPresenter: MenuConfigurator {
}

extension MenuPresenter: MenuPresenting {
}

extension MenuPresenter: MenuEventHandling {
}
