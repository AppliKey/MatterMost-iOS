//
//  ChatDetailsChatDetailsInteractor.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ChatDetailsInteractor {
  	weak var presenter: ChatDetailsPresenting!
    weak var channel: Channel!
    var service: PostsService!
    
    lazy var members: Dictionary<String, User> = { [unowned self] in
        var users = Dictionary<String, User>()
        
        if let members = self.channel.channelDetails?.members {
            for member in members {
                users[member.id] = member
            }
        }
        
        return users
    }()
    
    fileprivate var request:CancellableRequest?
    fileprivate var posts = [Post]()
    var hasNextPage = true

    deinit {
        request?.cancel()
    }
}

extension ChatDetailsInteractor: ChatDetailsInteracting {
    
    func getMorePosts(completion: @escaping PostsCompletion) {
        guard hasNextPage else {
            completion(.canceled())
            return
        }
        if posts.count > 0, let postId = posts.last?.id {
            request = service.requestMorePosts(afterPost: postId, completion: { [weak self] result in
                self?.handleCompletion(result, completion: completion)
            })
        } else {
            request = service.requestPosts(offset: "0", completion: { [weak self] result in
                self?.handleCompletion(result, completion: completion)
            })
        }
    }
    
    func refresh(completion: @escaping PostsCompletion) {
        posts = []
        hasNextPage = true
        getMorePosts(completion: completion)
    }
    
    func sendMessage(message:String, completion:@escaping PostCompletion) -> String {
        return service.sendPost(withMessage: message, channelId: channel.channelId, completion: completion)
    }
    
    private func handleCompletion(_ result:PostsResult, completion: @escaping PostsCompletion) {
        switch result {
        case .success(let posts):
            for post in posts {
                post.user = members[post.userId]
                post.isUnread = post.createDate > channel.lastViewedDate
            }
            self.posts.append(contentsOf: posts)
            hasNextPage = posts.count > 1
            completion(result)
        default:
            completion(result)
        }
    }
    
}
