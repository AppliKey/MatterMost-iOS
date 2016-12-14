//
//  ChatsChatsInteractor.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ChatsInteractor {
  	weak var presenter: ChatsPresenting!
    var mode:ChatsMode
    
    //MARK: - Init
    init(service: ChannelsService, mode:ChatsMode) {
        self.service = service
        self.mode = mode
        NotificationCenter.default.addObserver(self, selector: #selector(handleChatUpdated(notification:)),
                                               name: .updatedChanel, object: nil)
    }
    
    //MARK: - Private
    fileprivate let service: ChannelsService
    fileprivate var request: CancellableRequest?
    fileprivate var channels: [Channel]?
    
    @objc func handleChatUpdated(notification: Notification) {
        if let channel = notification.object as? Channel,
           let index = channels?.index(where: {$0.channelId == channel.channelId}) {
            channels?.remove(at: index)
            channels?.insert(channel, at: 0)
            presenter.newPost(in: channel, at: index)
        }
        checkIsUnread()
    }
    
    fileprivate func checkIsUnread() {
        let isUnread = channels?.filter{$0.isUnread == true}.count > 0 ? true : false
        presenter.updateTabBarItem(for: mode, isUnread: isUnread)
    }
    
    //MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
        request?.cancel()
    }
}

extension ChatsInteractor: ChatsInteracting {
    
    func refresh() {
        service.refresh(with: mode, completion: handleCompletion)
    }

    func loadChannels() {
        service.loadChannels(with: mode, completion: handleCompletion)
    }
    
    private func handleCompletion(withResult result:ChannelsResult) {
        switch result {
        case .success(let channels):
            self.channels = channels
            presenter.present(channels)
            getUserStatuses()
            checkIsUnread()
        case .failure(let errorMessage):
            presenter.present(errorMessage)
        }
    }
    
    func getChannelDetails(at index:Int) -> [CancellableRequest?] {
        guard let channel = channels?[index] else { return [] }
        let detailsRequest = service.getDetails(for: channel, completion: { [weak self] result in
            switch result {
            case .success(let channel):
                self?.presenter.update(channel: channel, at: index)
            case .failure(): break
            }
        })
        let messageRequest = service.getLastMessage(for: channel, completion: { [weak self] result in
            switch result {
            case .success(let channel):
                self?.presenter.update(channel: channel, at: index)
            case .failure(): break
            }
        })
        return [detailsRequest, messageRequest]
    }
    
    func getUserStatuses() {
        request = service.getUsersStatuses { [weak self]  result in
            switch result {
            case .success(let channels):
                self?.channels = channels
                self?.presenter.present(channels)
            case .failure(_): break
            }
        }
    }
    
    func getChannel(at index:Int) -> Channel? {
        return channels?[index]
    }
    
}
