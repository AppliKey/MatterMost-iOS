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
        DispatchQueue.main.async {
            self.view.hideActivityIndicator()
            self.view.updateView(with: channels.map(self.representation))
        }
    }
    
    func present(_ errorMessage: String) {
        DispatchQueue.main.async {
            self.view.alert(errorMessage)
        }
    }
    
    func update(channel: Channel, at index:Int) {
        DispatchQueue.main.async {
            self.view.updateCell(at: index, with: self.representation(for: channel))
        }
    }
    
    private func representation(for channel: Channel) -> ChatRepresentationModel {
        let chatRepresentation = ChatRepresentationModel()
        
        let isDirect = channel.type == ChannelType.direct
        chatRepresentation.chatName = isDirect ? channel.channelDetails?.members.first?.username ?? "" : channel.displayName
        chatRepresentation.isDirectChat = isDirect
        chatRepresentation.isPrivateChannel = channel.type == ChannelType.privateChat
        chatRepresentation.deliveryTime = DateHelper.chatTimeStringForDate(channel.lastPostAt)
        chatRepresentation.lastMessage = channel.lastPost ?? "Loading.."
        chatRepresentation.peopleCount = channel.channelDetails?.membersCount ?? 0
        chatRepresentation.isUnread = channel.isUnread
        let membersCount = channel.channelDetails?.members.count ?? 0
        if membersCount >= 4 {
            chatRepresentation.avatarUrl = channel.channelDetails?.members[0...4].map(getUrl)
        } else {
            chatRepresentation.avatarUrl = channel.channelDetails?.members.map(getUrl)
        }
        
        return chatRepresentation
    }
    
    private func getUrl(for user:User) -> URL? {
        guard let serverAddress = SessionManager.shared.serverAddress else { return nil }
        let urlString = serverAddress + "/api/v3/users/\(user.id)/image"
        return URL(string: urlString)
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
    
    func handleCellAppearing(at index:Int) -> [CancellableRequest?] {
        return interactor.getChannelDetails(at: index)
    }
}
