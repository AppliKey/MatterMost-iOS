//
//  ChatDetailsService.swift
//  Mattermost
//
//  Created by iOS_Developer on 05.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

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
        
        let target = PostsTarget(teamId: currentTeam, channelId: channel.channelId, offset: offset, limit: limit)
        return request(target, queue: queue) { [weak self] in
            do {
                let posts = try target.map($0)
                completion(.success(posts))
            } catch {
                guard let errorMessage = self?.errorMapper.message(for: error) else { return }
                completion(.failure(errorMessage))
            }
        }
    }
}
