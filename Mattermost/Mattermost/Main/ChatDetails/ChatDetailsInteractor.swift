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
    
    fileprivate var request:CancellableRequest?
    fileprivate var posts = [Post]()
    fileprivate var currentOffset = 0
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
            request = service.requestPosts(offset: "\(currentOffset)", completion: { [weak self] result in
                self?.handleCompletion(result, completion: completion)
            })
        }
    }
    
    private func handleCompletion(_ result:PostsResult, completion: @escaping PostsCompletion) {
        switch result {
        case .success(let posts):
            self.posts.append(contentsOf: posts)
            hasNextPage = posts.count > 1
            currentOffset += 1
            completion(result)
        default:
            completion(result)
        }
    }
    
}
