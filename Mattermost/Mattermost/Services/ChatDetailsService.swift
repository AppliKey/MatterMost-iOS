//
//  ChatDetailsService.swift
//  Mattermost
//
//  Created by iOS_Developer on 05.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import Moya

fileprivate let limit = "60"

enum PostsResult {
    case success([Post]), failure(String), canceled()
}

typealias PostsCompletion = (PostsResult) -> ()

class ChatDetailsService : NetworkService {
    
    fileprivate var channel: Channel

    fileprivate let errorMapper = ErrorMapper()
    fileprivate let queue = DispatchQueue(label: "posts.background", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent)
    
    init(withChannel channel:Channel) {
        self.channel = channel
    }
}

extension ChatDetailsService: PostsService {
    
    func requestPosts(offset:String, completion: @escaping PostsCompletion) -> CancellableRequest? {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = FirstPostsTarget(teamId: currentTeam, channelId: channel.channelId, offset: offset, limit: limit)
        return request(target, queue: queue) { [weak self] in
            do {
                let posts = try target.map($0)
                let sortedPosts = posts.sorted{$0.0.createDate < $0.1.createDate}
                completion(.success(sortedPosts))
            } catch {
                guard let errorMessage = self?.errorMapper.message(for: error) else { return }
                completion(.failure(errorMessage))
            }
        }
    }
    
    func requestMorePosts(afterPost postId:String, completion: @escaping PostsCompletion) -> CancellableRequest? {
        guard let currentTeam = SessionManager.shared.team?.id
            else { fatalError("Team is not selected") }
        
        let target = NextPostsTarget(teamId: currentTeam, channelId: channel.channelId,
                                     postId: postId, offset: "0", limit: limit)
        return request(target, queue: queue) { [weak self] in
            do {
                let posts = try target.map($0)
                let sortedPosts = posts.sorted{$0.0.createDate < $0.1.createDate}
                completion(.success(sortedPosts))
            } catch {
                guard let errorMessage = self?.errorMapper.message(for: error) else { return }
                completion(.failure(errorMessage))
            }
        }
    }
}
