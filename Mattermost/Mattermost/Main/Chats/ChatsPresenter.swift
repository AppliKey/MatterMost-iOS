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
    
    func present(_ channels: [Channel]) {
        view.updateView(withRepresentationModel: channels.map(representation))
    }
    
    func present(_ errorMessage: String) {
        view.alert(errorMessage)
    }
    
    private func representation(for channel: Channel) -> ChatRepresentationModel {
        let chatRepresentation = ChatRepresentationModel()
                
        chatRepresentation.chatName = channel.displayName
        chatRepresentation.isDirectChat = channel.type == ChannelType.direct
        chatRepresentation.isPrivateChannel = channel.type == ChannelType.privateChat
        chatRepresentation.deliveryTime = DateHelper.chatTimeStringForDate(channel.lastPostAt)
        
        return chatRepresentation
    }

}

extension ChatsPresenter: ChatsEventHandling {
    func openMenu() {
        coordinator.openMenu()
    }
    
    func refresh() {
        view.showActivityIndicator()
        interactor.loadChannels()
    }
}
