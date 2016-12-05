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
        request = service.requestPosts(offset: "\(currentOffset)", completion: { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts.append(contentsOf: posts)
                self?.hasNextPage = posts.count > 1
                self?.currentOffset += 1
                completion(result)
            default:
                completion(result)
            }
        })
    }
    
}
