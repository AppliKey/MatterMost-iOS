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
    
    //MARK: - Init
    init(service: ChannelsService) {
        self.service = service
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
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        request = service.getAllChannels(forTeamId: currentTeam, completion: { [weak self]  result in
            switch result {
            case .success(let channels):
                break
                //self?.presenter.present(teams)
            case .failure(let errorMessage):
                break
                //self?.presenter.present(errorMessage)
            }
        })
    }
    
}

enum ChannelsResult {
    case success([Channel]), failure(String)
}

typealias ChannelsCompletion = (ChannelsResult) -> ()

protocol ChatsService {
    func getAllChannels(forTeamId teamId:String, completion: @escaping ChannelsCompletion) -> CancellableRequest
}
