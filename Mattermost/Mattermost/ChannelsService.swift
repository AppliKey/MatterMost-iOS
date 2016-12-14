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
    
    fileprivate var queue = DispatchQueue(label: "chats.background", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent)
    
    init() {
        guard let currentTeam = SessionManager.shared.team?.id
            else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewPost(notification:)),
                                               name: .newPost(inTeam: currentTeam), object: nil)
    }
    
    @objc fileprivate func handleNewPost(notification: Notification) {
        debugPrint(notification)
        if let post = notification.object as? Post,
           let channel = allChannels.first(where: {$0.channelId == post.channelId}) {
            channel.lastPost = post.message
            channel.lastPostAt = post.createDate
            NotificationCenter.default.post(Notification(name: .updatedChanel, object: channel, userInfo: nil))
        }
    }
    
    fileprivate func requestAllChannels(forTeamId teamId:String, completion: @escaping ChannelsCompletion) -> CancellableRequest {
        let target = ChannelsTarget(teamId: teamId)
        return request(target, queue: queue) {
            do {
                var channels = try target.map($0)
                channels.sort{$0.0.lastPostAt > $0.1.lastPostAt}
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
        case .unread:
            filteredChannels = allChannels.filter{$0.isUnread == true}
        default:
            filteredChannels = allChannels
        }
        return filteredChannels
    }
    
    fileprivate func requestDetails(forChannel channel: Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest {
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
    
    fileprivate func requestLastMesage(forChannel channel: Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = FirstPostsTarget(teamId: currentTeam, channelId: channel.channelId, offset: "0", limit: "1")
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
    
    
    fileprivate func getOtherUsersIds() -> [String] {
        let directChats = allChannels.filter{$0.type == ChannelType.direct}
        let otherUserIds: [String?] = directChats.map{$0.otherUserId}
        return otherUserIds.flatMap{$0}
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        request = requestAllChannels(forTeamId: currentTeam, completion: { [weak self]  result in
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
    
    func getDetails(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest? {
        if channel.channelDetails != nil {
            completion(.success(channel))
            return nil
        }
        let request = requestDetails(forChannel: channel, completion: completion)
        return request
    }
    
    func getLastMessage(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest? {
        if channel.lastPost != nil {
            completion(.success(channel))
            return nil
        }
        let request = requestLastMesage(forChannel: channel, completion: completion)
        return request
    }
    
    func getUsersStatuses(completion: @escaping ChannelsCompletion) -> CancellableRequest {
        let target = UserStatusesTarget(userIds: getOtherUsersIds())
        return request(target, queue: queue) {
            do {
                let statuses = try target.map($0)
                let directChats = self.allChannels.filter{$0.type == ChannelType.direct}
                for chat in directChats {
                    chat.onlineStatus = statuses[chat.otherUserId!]
                }
                completion(.success(self.filteredChannels))
            } catch {
                completion(.failure(""))
            }
        }
    }
    
    func refresh(with mode:ChatsMode, completion: @escaping ChannelsCompletion) {
        self.allChannels = []
        loadChannels(with: mode, completion: completion)
    }
}
