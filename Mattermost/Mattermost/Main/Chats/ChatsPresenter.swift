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
    fileprivate var isViewLoaded = false
	
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
    
    func updateTabBarItem(for mode:ChatsMode, isUnread: Bool) {
        DispatchQueue.main.async {
            self.view.updateTabBarItem(for: mode, isUnread: isUnread)
        }
    }
    
    func newPost(in channel: Channel, at index:Int) {
        guard isViewLoaded else { return }
        DispatchQueue.main.async {
            self.view.moveToTop(channel: self.representation(for: channel), fromIndex: index)
        }
    }
    
    func present(_ channels: [Channel]) {
        guard isViewLoaded else { return }
        DispatchQueue.main.async {
            self.view.hideActivityIndicator()
            self.view.updateView(with: channels.map(self.representation))
        }
    }
    
    func present(_ errorMessage: String) {
        guard isViewLoaded else { return }
        DispatchQueue.main.async {
            self.view.alert(errorMessage)
        }
    }
    
    func update(channel: Channel, at index:Int) {
        guard isViewLoaded else { return }
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
        if let date = channel.lastPostAt {
            chatRepresentation.deliveryTime = DateHelper.chatTimeStringForDate(date)
            chatRepresentation.lastMessage = channel.lastPost ?? R.string.localizable.loadingMessagesTitle()
        } else {
            chatRepresentation.lastMessage = R.string.localizable.noMessages()
        }
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
        return user.avatarUrl
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
        isViewLoaded = true
        view.showActivityIndicator()
        interactor.loadChannels()
    }
    
    func handleCellAppearing(at index:Int) -> [CancellableRequest?] {
        return interactor.getChannelDetails(at: index)
    }
    
    func handleRowSelection(at index:Int) {
        if let channel = interactor.getChannel(at: index) {
            coordinator.openDetails(forChannel: channel)
        }
    }
}
