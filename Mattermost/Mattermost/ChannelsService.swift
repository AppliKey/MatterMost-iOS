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

enum ChannelMessageResult {
    case success(Post?), failure()
}

typealias ChannelsCompletion = (ChannelsResult) -> ()
typealias ChannelDetailsCompletion = (ChannelDetailsResult) -> ()
typealias ChannelMessageCompletion = (ChannelMessageResult) -> ()

class ChannelsService : NetworkService {
    fileprivate let errorMapper = ErrorMapper()
    fileprivate var allChannels = [Channel]()
    fileprivate var isLoading = false
    fileprivate var request:CancellableRequest?
    
    fileprivate func getAllChannels(forTeamId teamId:String, completion: @escaping ChannelsCompletion) -> CancellableRequest {
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
    
    fileprivate func filterChannels(forMode mode:ChatsMode) -> [Channel] {
        switch mode {
        case .publicChats:
            return allChannels.filter{$0.type == ChannelType.publicChat}
        case .privateChats:
            return allChannels.filter{$0.type == ChannelType.privateChat}
        case .direct:
            return allChannels.filter{$0.type == ChannelType.direct}
        default:
            return allChannels
        }
    }
    
    fileprivate func getChannelDetails(_ channel: Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = ChannelDetailsTarget(teamId: currentTeam, channelId: channel.channelId)
        return request(target) {
            do {
                channel.channelDetails = try target.map($0)
                completion(.success(channel))
            } catch {
                completion(.failure())
            }
        }
    }
    
    fileprivate func getLastMesage(forChannel channel: Channel, completion: @escaping ChannelMessageCompletion) -> CancellableRequest {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = PostsTarget(teamId: currentTeam, channelId: channel.channelId, offset: "0", limit: "1")
        return request(target) {
            do {
                let posts = try target.map($0)
                channel.lastPost = posts.first?.message
                completion(.success(posts.first))
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
    func loadChannels(withMode mode:ChatsMode, completion: @escaping ChannelsCompletion) {
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
                completion(.success(channels))
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        })
    }
    
    func getChannelDetails(forChannel channel:Channel) {
        let _ = getChannelDetails(channel, completion: { [weak self]  result in
            switch result {
            case .success(let channel):
                let _ = self?.allChannels.count
                print(channel)
            case .failure(): break
            }
        })
    }
    
    func getLastMessage(forChannel channel:Channel) {
        let _ = getLastMesage(forChannel: channel, completion: { [weak self]  result in
            switch result {
            case .success(let post):
                let _ = self?.allChannels.count
                print(post)
            case .failure(): break
            }
        })
    }
    
}
