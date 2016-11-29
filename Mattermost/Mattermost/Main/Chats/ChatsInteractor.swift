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
    }
    
    //MARK: - Private
    fileprivate let service: ChannelsService
    fileprivate var request: CancellableRequest?
    fileprivate var channels: [Channel]?
    
    //MARK: - Deinit
    deinit {
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
        case .failure(let errorMessage):
            presenter.present(errorMessage)
        }
    }
    
    func getChannelDetails(at index:Int) -> [CancellableRequest?] {
        guard let channel = channels?[index] else { return [] }
        let detailsRequest = service.getDetails(for: channel, completion: { result in
            switch result {
            case .success(let channel):
                self.presenter.update(channel: channel, at: index)
            case .failure(): break
            }
        })
        let messageRequest = service.getLastMessage(for: channel, completion: { result in
            switch result {
            case .success(let channel):
                self.presenter.update(channel: channel, at: index)
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
    
}
