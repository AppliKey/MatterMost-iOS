//
//  ChannelsService.swift
//  Mattermost
//
//  Created by iOS_Developer on 22.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class ChannelsService : NetworkService {
    fileprivate let errorMapper = ErrorMapper()
}

extension ChannelsService : ChatsService {
    
    func getAllChannels(forTeamId teamId:String, completion: @escaping ChannelsCompletion) -> CancellableRequest {
        let target = ChannelsTarget(teamId: teamId)
        return request(target) {
            do {
                let channels = try target.map($0)
                completion(.success(channels))
            } catch {
                let errorMessage = self.errorMapper.message(for: error)
                completion(.failure(errorMessage))
            }
        }
    }
    
}
