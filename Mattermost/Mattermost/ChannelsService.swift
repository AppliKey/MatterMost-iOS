//
//  ChannelsService.swift
//  Mattermost
//
//  Created by iOS_Developer on 22.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

enum ChannelsResult {
    case success([Channel]), failure(String)
}

enum ChannelDetailsResult {
    case success(Channel), failure()
}

typealias ChannelsCompletion = (ChannelsResult) -> ()
typealias ChannelDetailsCompletion = (ChannelDetailsResult) -> ()

class ChannelsService : NetworkService {
    fileprivate let errorMapper = ErrorMapper()
    fileprivate var allChannels = [Channel]()
    fileprivate var filteredChannels = [Channel]()
    fileprivate var isLoading = false
    fileprivate var request:CancellableRequest?
    
    private var queue = DispatchQueue(label: "chats.background", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent)
    
    fileprivate func getAllChannels(forTeamId teamId:String, completion: @escaping ChannelsCompletion) -> CancellableRequest {
        let target = ChannelsTarget(teamId: teamId)
        return request(target, queue: queue) {
            do {
                let channels = try target.map($0)
                completion(.success(channels))
            } catch {
                let errorMessage = self.errorMapper.message(for: error)
                completion(.failure(errorMessage))
            }
        }
    }
    
    fileprivate func filterChannels(forMode mode:ChatsMode) -> [Channel] {
        switch mode {
        case .publicChats:
            filteredChannels = allChannels.filter{$0.type == ChannelType.publicChat}
        case .privateChats:
            filteredChannels = allChannels.filter{$0.type == ChannelType.privateChat}
        case .direct:
            filteredChannels = allChannels.filter{$0.type == ChannelType.direct}
        default:
            filteredChannels = allChannels
        }
        return filteredChannels
    }
    
    fileprivate func getChannelDetails(_ channel: Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = ChannelDetailsTarget(teamId: currentTeam, channelId: channel.channelId)
        return request(target, queue: queue) {
            do {
                channel.channelDetails = try target.map($0)
                completion(.success(channel))
            } catch {
                completion(.failure())
            }
        }
    }
    
    fileprivate func getLastMesage(forChannel channel: Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = PostsTarget(teamId: currentTeam, channelId: channel.channelId, offset: "0", limit: "1")
        return request(target, queue: queue) {
            do {
                let posts = try target.map($0)
                channel.lastPost = posts.first?.message
                completion(.success(channel))
            } catch {
                completion(.failure())
            }
        }
    }
    
    deinit {
        request?.cancel()
    }
}

extension ChannelsService : ChatsService {
    func loadChannels(with mode:ChatsMode, completion: @escaping ChannelsCompletion) {
        if allChannels.count > 0 {
            completion(.success(filterChannels(forMode: mode)))
            return
        }
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        guard isLoading == false else { return }
        
        isLoading = true
        request = getAllChannels(forTeamId: currentTeam, completion: { [weak self]  result in
            self?.isLoading = false
            switch result {
            case .success(let channels):
                self?.allChannels = channels
                if let filtered = self?.filterChannels(forMode: mode) {
                    completion(.success(filtered))
                }
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        })
    }
    
    func getChannelDetails(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest? {
        if channel.channelDetails != nil {
            completion(.success(channel))
            return nil
        }
        let request = getChannelDetails(channel, completion: completion)
        return request
    }
    
    func getLastMessage(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest? {
        if channel.lastPost != nil {
            completion(.success(channel))
            return nil
        }
        let request = getLastMesage(forChannel: channel, completion: completion)
        return request
    }
    
}
