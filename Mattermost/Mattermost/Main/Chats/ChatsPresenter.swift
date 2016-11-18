//
//  ChatsChatsPresenter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ChatsPresenter {
    
	//MARK: - Properties
    weak var view: ChatsViewing!
    var interactor: ChatsInteracting!
    var representationModels = [ChatRepresentationModel]()
	
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
    
    func viewIsReady() {
        addRandomChats()
        view.updateView(withRepresentationModel: representationModels)
    }
    
    func addRandomChats() {
        for _ in 0...20 {
            let model = ChatRepresentationModel()
            model.avatarUrl = nil
            model.chatName = UUID().uuidString
            model.deliveryTime = "03:55 PM"
            model.lastMessage = UUID().uuidString + UUID().uuidString
            model.isPrivateChannel = true
            model.onlineStatusColor = UIColor.green
            model.isUnread = Int(arc4random()) % 2 == 0
            model.isDirectChat = true
            representationModels.append(model)
        }
    }
}
