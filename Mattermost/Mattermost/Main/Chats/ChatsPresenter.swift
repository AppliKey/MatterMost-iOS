//
//  ChatsChatsPresenter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ChatsPresenter {
    
	//MARK: - Properties
    weak var view: ChatsViewing!
    var interactor: ChatsInteracting!
	
	//MARK: - Init
    
    required init(coordinator: ChatsCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: ChatsCoordinator
}

extension ChatsPresenter: ChatsConfigurator {
}

extension ChatsPresenter: ChatsPresenting {
}

extension ChatsPresenter: ChatsEventHandling {
    func openMenu() {
        coordinator.openMenu()
    }
}
