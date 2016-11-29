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
        guard let userId = SessionManager.shared.user?.id else {
            fatalError("User is nil")
        }
        chatRepresentation.chatName = isDirect ? channel.channelDetails?.members.filter{$0.id != userId}.first?.username ?? ""
                                               : channel.displayName
        chatRepresentation.isDirectChat = isDirect
        chatRepresentation.isPrivateChannel = channel.type == ChannelType.privateChat
        chatRepresentation.deliveryTime = DateHelper.chatTimeStringForDate(channel.lastPostAt)
        chatRepresentation.lastMessage = channel.lastPost ?? "Loading.."
        chatRepresentation.peopleCount = channel.channelDetails?.membersCount ?? 0
        chatRepresentation.isUnread = channel.isUnread
        chatRepresentation.onlineStatus = channel.onlineStatus ?? .offline
        let membersCount = channel.channelDetails?.members.count ?? 0
        if membersCount >= 4 {
            chatRepresentation.avatarUrl = channel.channelDetails?.members[0...3].map(getUrl)
        } else {
            chatRepresentation.avatarUrl = channel.channelDetails?.members.map(getUrl)
        }
        
        if isDirect, let serverAddress = SessionManager.shared.serverAddress,
            let userId = channel.otherUserId {
            let urlString = serverAddress + "/api/v3/users/\(userId)/image"
            chatRepresentation.avatarUrl = [URL(string: urlString)]
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
        interactor.refresh()
    }
    
    func viewIsReady() {
        view.showActivityIndicator()
        interactor.loadChannels()
    }
    
    func handleCellAppearing(at index:Int) -> [CancellableRequest?] {
        return interactor.getChannelDetails(at: index)
    }
}
