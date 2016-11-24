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
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
    
}

extension ChatsInteractor: ChatsInteracting {

    func loadChannels() {
        service.loadChannels(withMode: mode) { [weak self]  result in
            switch result {
            case .success(let channels):
                self?.presenter.present(channels)
                self?.service.getChannelDetails(forChannel: channels.first!)
                self?.service.getLastMessage(forChannel: channels.first!)
            case .failure(let errorMessage):
                self?.presenter.present(errorMessage)
            }
        }
    }
    
}


protocol ChatsService {
    func loadChannels(withMode mode:ChatsMode, completion: @escaping ChannelsCompletion)
    func getChannelDetails(forChannel channel:Channel)
    func getLastMessage(forChannel channel:Channel)
}
